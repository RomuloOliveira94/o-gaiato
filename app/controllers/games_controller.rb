class GamesController < ApplicationController
  before_action :set_game, only: [ :show, :start, :vote, :destroy, :leave, :kick_player ]
  before_action :check_game_token, only: [ :show ]

  def create
    @game = Game.new
    @player = @game.players.new(player_params)
    @game.game_code = generate_game_code
    if @game.save
      save_game_session
      save_session_player(@player)
      associate_game_owner(@game, @player)
      redirect_to game_path(@game.game_code)
    else
      redirect_to root_path, alert: "Não foi possível criar o jogo."
    end
  end

  def show; end

  def join
    @game = Game.find_by(game_code: game_params[:game_code])
    if @game
      @player = @game.players.new(player_params) if @game
      if @player.save
        save_game_session
        save_session_player(@player)
        redirect_to game_path(@game.game_code)
      else
        redirect_to game_path(@game.game_code), alert: "Nome de jogador inválido."
      end
    else
      redirect_to root_path, alert: "Jogo não encontrado."
    end
  end

  def start
    if @game.players.count >= 3
      @game.assign_roles_and_words
      if @game.save
        redirect_to game_path(@game.game_code), notice: "Jogo iniciado com sucesso!"
      else
        redirect_to game_path(@game.game_code), alert: "Não foi possível iniciar o jogo."
      end
    else
      redirect_to game_path(@game.game_code), alert: "É necessário pelo menos 3 jogadores para iniciar."
    end
  end

  def vote
    @player = Current.player
    if @player && !@player.has_voted && @game.status == "in_progress" && params[:voted_for_player_id].present?
      @player.update(voted_for_player_id: params[:voted_for_player_id], has_voted: true)
      @game.check_game_end_conditions
      redirect_to game_path(@game.game_code), notice: "Seu voto foi computado!"
    else
      redirect_to game_path(@game.game_code), alert: "Vote em um jogador."
    end
  end

  def destroy
    if Current.player&.id == @game.owner&.id
      begin
        ActiveRecord::Base.transaction do
          @game.update!(owner_id: nil, spy_player_id: nil)

          @game.destroy!
        end

        session[:player_id] = nil
        destroy_game_session
        redirect_to root_path, notice: "Jogo cancelado com sucesso."
      rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotDestroyed => e
        Rails.logger.error "Erro ao deletar jogo: #{e.message}"
        redirect_to game_path(@game.game_code), alert: "Erro ao deletar o jogo."
      end
    else
      redirect_to game_path(@game.game_code), alert: "Apenas o criador do jogo pode cancelá-lo."
    end
  end

  def leave
    if Current.player && @game.players.include?(Current.player)

      if Current.player.id == @game.owner&.id
        redirect_to game_path(@game.game_code), alert: "O criador do jogo não pode sair. Use 'Cancelar Jogo' para deletar o jogo."
        return
      end

      if @game.in_progress? || @game.finished?
        redirect_to game_path(@game.game_code), alert: "Não é possível sair de um jogo em andamento."
        return
      end

      Current.player.destroy
      session[:player_id] = nil
      destroy_game_session

      redirect_to root_path, notice: "Você saiu."
    else
      redirect_to root_path, alert: "Você não está neste jogo."
    end
  end

  def kick_player
    @player = @game.players.find(params[:player_id])
    if @player && @player != @game.owner
      UserRedirectChannel.broadcast_to(@player, leave: leave_game_path)
    else
      redirect_to game_path(@game.game_code), alert: "Não foi possível expulsar o jogador."
    end
  end

  private

  def set_game
    @game = Game.find_by(game_code: params[:game_code])
    unless @game
      redirect_to root_path, alert: "Jogo não encontrado."
    end
  end

  def game_params
    params.require(:game).permit(:game_code)
  end

  def player_params
    params.require(:player).permit(:name)
  end

  def generate_game_code
    SecureRandom.alphanumeric(6).upcase
  end

  def save_session_player(player)
    session[:player_id] = player.id if player.persisted?

    cookies.encrypted[:player_id] = { value: player.id, httponly: true }
    cookies[:player_js] = { value: player.id, httponly: false, path: "/" }
  end

  def associate_game_owner(game, player)
    game.owner = player
    game.save!
  end

  def save_game_session
    session[:game_token] = "#{@game.id}_#{request.remote_ip}" if @game
  end

  def destroy_game_session
    session[:game_token] = nil
  end

  def check_game_token
    if session[:game_token].blank? || session[:game_token] != "#{@game.id}_#{request.remote_ip}"
      redirect_to root_path, alert: "Acesso não autorizado ao jogo."
    end
  end
end
