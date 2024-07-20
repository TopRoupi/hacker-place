module Broadcast
  class DE < ApplicationBroadcast
    attr_reader :machine_id

    def initialize(machine_id)
      @machine_id = machine_id
    end

    def open_app(app_component)
      # this is getting out of hand
      # app_taskbar_component = render(Desktop::TaskbarAppComponent.new(name: app, app_id: app_id))

      app_taskbar_component = Desktop::TaskbarAppComponent.new(
        name: app_component.app,
        app_id: app_component.app_id
      )

      cable_ready[DEChannel]
        .append(
          selector: "#taskbar-open-apps",
          html: render(app_taskbar_component)
        )
        .append(
          selector: "#desktop-open-apps",
          html: render(app_component)
        )
        .dispatch_event(
          name: "register-app-window",
          detail: {
            appId: app_component.app_id
          }
        )
        .broadcast_to(machine_id)
    end

    def close_app(app_id)
    end
  end
end
