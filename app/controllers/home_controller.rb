class HomeController < ApplicationController
  def index
    render Home::IndexView
  end
end
