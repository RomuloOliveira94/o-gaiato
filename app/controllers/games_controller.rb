class GamesController < ApplicationController
  before_action :set_game, only: [ :show, :start, :vote ]

  def create
    @game = Game.new
    @player = @game.players.new(player_params)
    @game.game_code = generate_game_code
    @game.game_owner = @player
    if @game.save
      save_session_player(@player)
      redirect_to game_path(@game.game_code)
    else
      redirect_to root_path, alert: "Could not create game."
    end
  end

  def show; end

  def join
    @game = Game.find_by!(game_code: game_params[:game_code])
    @player = @game.players.new(player_params)
    if @player.save
      save_session_player(@player)
      redirect_to game_path(@game.game_code)
    else
      redirect_to root_path, alert: "Could not join game."
    end
  end

  def start
    @game = Game.find(params[:id])
    if @game.players.count >= 3
      @game.assign_roles_and_words
      if @game.save
        redirect_to @game, notice: "Game started!"
      else
        redirect_to @game, alert: "Could not start game."
      end
    else
      redirect_to @game, alert: "Not enough players to start."
    end
  end

  def vote
    @game = Game.find(params[:id])
    @player = Player.find(session[:player_id]) # Get current player from session
    if @player && !@player.has_voted && @game.status == "in_progress"
      @player.update(voted_for_player_id: params[:voted_for_player_id], has_voted: true)
      # Check if all players have voted and resolve game
      @game.check_game_end_conditions # Method in Game model
      # Use Turbo Streams to update UI for all players
      redirect_to @game, notice: "Your vote has been cast!"
    else
      redirect_to @game, alert: "Unable to cast vote."
    end
  end

  private

  def set_game
    @game = Game.find_by(game_code: params[:game_code])
    unless @game
      redirect_to root_path, alert: "Game not found."
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
end
