class HomeController < ApplicationController
  def index
    @player = Player.new
  end
end
