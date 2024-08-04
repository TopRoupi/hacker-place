class DEChannel < ApplicationCable::Channel
  def subscribed
    @machine_id = params["machineId"]
    stream_for @machine_id

    @broadcaster = DEBroadcast.new(@machine_id)
  end

  def receive(data)
  end

  def open(args)
    args.symbolize_keys => {app:, args:}

    component = Desktop::AppFactory.get_app_component(
      app,
      {
        machine_id: @machine_id,
        args: args
      }
    )
    app_component = Desktop::AppComponent.new(component: component)

    @broadcaster.open_app(app_component)
  end

  def close(args)
  end
end
