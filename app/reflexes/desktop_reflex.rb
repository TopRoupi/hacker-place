class DesktopReflex < ApplicationReflex
  # gabage code most of this logic should be in a stimulus controller
  def open
    app_id = "app-#{SecureRandom.hex}"
    app = element.dataset[:app]

    component = Desktop::AppFactory.get_app_component(
      app, {computer_id: Computer.last.id, app_id: app_id}
    )

    app_component = render(Desktop::AppComponent.new(app: app, id: app_id, component: component))
    app_taskbar_component = render(Desktop::TaskbarAppComponent.new(name: app, app_id: app_id))

    cable_ready
      .append(
        selector: "#taskbar-open-apps",
        html: app_taskbar_component
      )
      .append(
        selector: "#desktop-open-apps",
        html: app_component
      )
    morph :nothing
  end

  def focus
    app_id = element.dataset[:id]

    cable_ready
      .remove_css_class(
        selector: "##{app_id}",
        name: "hidden"
      )

    morph :nothing
  end

  def close
    app_id = element.dataset[:id]

    cable_ready
      .remove(
        selector: "##{app_id}"
      )
      .remove(
        selector: "##{app_id}-taskbar"
      )

    morph :nothing
  end
end
