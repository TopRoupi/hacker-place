# frozen_string_literal: true

class Home::IndexView < ApplicationView
  def initialize(computer:)
    @computer = computer
  end

  def template
    div(data_controller: "cable-from", data_cable_from_id_value: "test")

    div(
      id: "de",
      class: "flex flex-col min-h-screen",
      style: "background-image: url(\"#{image_url("wallpaper.png")}\"); background-size: cover;",
      data: {
        controller: "de",
        de_computer_id_value: @computer.id,
        de_active_app_value: ""
      }
    ) do
      div(
        id: "desktop-open-apps",
        class: "flex-1 flex",
        data: {
          de_target: "desktop"
        }
      ) do
      end
      div(class: "bg-secondary flex z-10", data: {de_target: "taskbar"}) do
        div(class: "dropdown dropdown-top") do
          button(class: "bg-primary text-primary-content px-2 py-2") { "Apps" }
          ul(
            tabindex: "0",
            class:
            "dropdown-content z-[1] menu p-2 shadow bg-base-200 w-52"
          ) do
            Desktop::AppFactory::APPS.each do |app|
              li do
                button(
                  data_reflex: "click->DesktopReflex#open",
                  data_app: app
                ) { app }
              end
            end
          end
        end
        div(id: "taskbar-open-apps", class: "flex") do
        end
      end
    end
  end
end
