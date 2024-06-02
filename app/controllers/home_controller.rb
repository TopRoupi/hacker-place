class HomeController < ApplicationController
  before_action :authenticate_player!, only: [:index]

  def index
    render Home::IndexView.new(computer: current_player.computer)
  end
end
