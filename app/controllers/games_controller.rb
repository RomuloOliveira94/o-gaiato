class GamesController < ApplicationController
  before_action :set_game, only: [ :show, :start, :vote ]

  def create
    @game = Game.new
    @player = @game.players.new(player_params)
    @game.game_code = generate_game_code
    if @game.save
      save_session_player(@player)
      associate_game_owner(@game, @player)
      redirect_to game_path(@game.game_code)
    else
      Rails.logger.error(@game.errors.full_messages.join(", "))
      redirect_to root_path, alert: "Não foi possível criar o jogo."
    end
  end

  def show; end

  def join
    @game = Game.find_by(game_code: game_params[:game_code])
    if @game
      @player = @game.players.new(player_params) if @game
      if @player.save
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
    puts "Starting game with code: #{@game.game_code}"
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
    @player = Player.find(session[:player_id])
    if @player && !@player.has_voted && @game.status == "in_progress"
      @player.update(voted_for_player_id: params[:voted_for_player_id], has_voted: true)
      # Check if all players have voted and resolve game
      @game.check_game_end_conditions # Method in Game model
      # Use Turbo Streams to update UI for all players
      redirect_to @game, notice: "Seu voto foi computado!"
    else
      redirect_to @game, alert: "Não foi possível votar."
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
  end

  def associate_game_owner(game, player)
    game.owner = player
    game.save!
  end
end
