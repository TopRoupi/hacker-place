# frozen_string_literal: true

class Home::IndexView < ApplicationView
  def initialize(computer:)
    @computer = computer
  end

  def template
    render DesktopEnvironmentComponent.new(computer: @computer)
  end
end
