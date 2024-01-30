# frozen_string_literal: true

class Home::IndexView < ApplicationView
  def initialize(computer:)
    @computer = computer

    @apps = [:terminal, :files]
  end

  def template
    div(data_controller: "cable-from", data_cable_from_id_value: "test")

    div(
      class: "flex flex-col min-h-screen",
      data: {
        controller: "desktop"
      }
    ) do
      div(class: "flex-1") do
        render FileExplorerComponent.new(@computer)
        render TerminalComponent.new
      end
      div(class: "bg-secondary flex") do
        div(class: "dropdown dropdown-top") do
          button(class: "bg-primary text-primary-content px-2 py-2") { "Apps" }
          ul(
            tabindex: "0",
            class:
            "dropdown-content z-[1] menu p-2 shadow bg-base-200 w-52"
          ) do
            @apps.each do |app|
              li do
                button { app }
              end
            end
          end
        end
        div(id: "taskbar-open-apps", class: "flex") do
          render Desktop::TaskbarAppComponent.new("Files")
        end
      end
    end
  end
end
