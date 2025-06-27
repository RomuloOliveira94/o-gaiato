class HomeController < ApplicationController
  skip_before_action :set_current_attributes
  def index
    @player = Player.new
  end
end
