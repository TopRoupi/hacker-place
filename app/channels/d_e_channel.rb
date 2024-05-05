class DEChannel < ApplicationCable::Channel
  def subscribed
    stream_for params["computerId"]
  end

  def open(args)
    broadcaster = Broadcast::DE.new(params["computerId"])

    args.symbolize_keys => {app:, args:}

    # HACK opening terminal is hard coded
    # the app should be generated using the args
    component = Desktop::AppFactory.get_app_component(
      app,
      {
        computer_id: params["computerId"],
        args: [args["code"], args["args"]]
      }
    )
    app_component = Desktop::AppComponent.new(component: component)

    broadcaster.open_app(app_component)
  end

  def close(args)
  end
end
