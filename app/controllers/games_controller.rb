class GamesController < ApplicationController
  before_action :set_game, only: [ :show, :start, :vote, :destroy, :leave, :kick_player ]
  before_action :check_player, only: [ :show, :leave, :vote, :destroy ]

  def create
    @game = Game.new
    @player = @game.players.new(player_params)
    @game.game_code = generate_game_code
    if @game.save
      associate_game_owner(@game, @player)
      redirect_to game_path(@game.game_code)
    else
      redirect_to root_path, alert: "Não foi possível criar o jogo."
    end
  end

  def show; end

  def join
    @game = Game.find_by(game_code: params[:game_code])
    unless @game
      redirect_to root_path, alert: "Jogo não encontrado."
      return
    end

    @player = Player.find_or_initialize_by(session_id: session.id.to_s)
    @player.assign_attributes(player_params.merge(game: @game))
    if @player.save
      redirect_to game_path(@game.game_code)
    else
      redirect_to root_path, alert: "Nome de jogador inválido."
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
    if @player && !@player.has_voted && @game.status == "in_progress" && params[:voted_for_player_id].present?
      @player.update(voted_for_player_id: params[:voted_for_player_id], has_voted: true)
      @game.check_game_end_conditions
      redirect_to game_path(@game.game_code), notice: "Seu voto foi computado!"
    else
      redirect_to game_path(@game.game_code), alert: "Vote em um jogador."
    end
  end

  def destroy
    if @player&.id == @game.owner&.id
      begin
        ActiveRecord::Base.transaction do
          @game.update!(owner_id: nil, spy_player_id: nil)

          @game.destroy!
        end

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
    if @player && @game.players.include?(@player)

      if @player.id == @game.owner&.id
        redirect_to game_path(@game.game_code), alert: "O criador do jogo não pode sair. Use 'Cancelar Jogo' para deletar o jogo."
        return
      end

      if @game.in_progress? || @game.finished?
        redirect_to game_path(@game.game_code), alert: "Não é possível sair de um jogo em andamento."
        return
      end

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

  def associate_game_owner(game, player)
    game.owner = player
    game.save!
  end

  def check_player
    @player = @game.players.find_by(session_id: session.id.to_s)
    unless @player
      redirect_to root_path, alert: "Não autorizado. Por favor, entre no jogo."
    end
  end
end
