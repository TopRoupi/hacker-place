class HomeController < ApplicationController
  # before_action :authenticate_player!, only: [:index]

  def index
    # HACK
    Computer.create if Computer.all.count == 0

    render Home::IndexView.new(computer: Computer.last)
  end
end
