module Broadcast
  class DE < ApplicationBroadcast
    attr_reader :computer_id

    def initialize(computer_id)
      @computer_id = computer_id
    end

    def open_app(app_component)
      # this is getting out of hand
      # app_taskbar_component = render(Desktop::TaskbarAppComponent.new(name: app, app_id: app_id))

      app_taskbar_component = Desktop::TaskbarAppComponent.new(
        name: app_component.app,
        app_id: app_component.app_id
      )

      cable_ready[DEChannel]
        .set_attribute(
          selector: "#de",
          name: "data-de-active-app-value",
          value: app_component.app_id
        )
        .append(
          selector: "#taskbar-open-apps",
          html: render(app_taskbar_component)
        )
        .append(
          selector: "#desktop-open-apps",
          html: render(app_component)
        )
        .broadcast_to(computer_id)
    end

    def close_app(app_id)
    end
  end
end
