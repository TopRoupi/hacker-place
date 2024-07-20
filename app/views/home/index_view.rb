# frozen_string_literal: true

class Home::IndexView < ApplicationView
  def initialize(machine:)
    @machine = machine
  end

  def view_template
    render DesktopEnvironmentComponent.new(machine: @machine)
  end
end
