class HomeController < ApplicationController
  def index
    render Home::IndexView.new(machine: Current.player.machine)
  end
end
