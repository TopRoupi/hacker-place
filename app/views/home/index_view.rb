# frozen_string_literal: true

class Home::IndexView < ApplicationView
  def initialize(computer:)
    @computer = computer
  end

  def template
    div(
      id: "de",
      class: "flex flex-col min-h-screen",
      style: "background-image: url(\"#{image_url("wallpaper.png")}\"); background-size: cover;",
      data: {
        action: "ide:open->de#open app-window:focus->de#focus app-window:close->de#close taskbar:open->de#open",
        controller: "de",
        de_computer_id_value: @computer.id,
        de_active_app_value: ""
      }
    ) {
      desktop
      taskbar
    }
  end

  def desktop
    div(
      id: "desktop-open-apps",
      class: "flex-1 flex",
      data: {
        de_target: "desktop"
      }
    ) {}
  end

  def taskbar
    div(
      class: "bg-secondary flex z-10",
      data: {
        de_target: "taskbar",
        controller: "taskbar"
      }
    ) {
      div(class: "dropdown dropdown-top") {
        button(class: "bg-primary text-primary-content px-2 py-2") { "Apps" }
        ul(
          tabindex: "0",
          class:
          "dropdown-content z-[1] menu p-2 shadow bg-base-200 w-52"
        ) {
          Desktop::AppFactory::APPS.each { |app|
            li {
              button(
                data: {
                  # reflex: "click->DesktopReflex#open",
                  action: "click->taskbar#openApp",
                  app: app
                }
              ) { app }
            }
          }
        }
      }
      div(id: "taskbar-open-apps", class: "flex") {}
    }
  end
end
