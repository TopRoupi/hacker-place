class HomeController < ApplicationController
  def index
    render Home::IndexView.new(computer: Current.player.computer)
  end
end
