class DEChannel < ApplicationCable::Channel
  def subscribed
    @computer_id = params["computerId"]
    stream_for @computer_id

    @broadcaster = Broadcast::DE.new(@computer_id)
  end

  def receive(data)
  end

  def open(args)
    args.symbolize_keys => {app:, args:}

    component = Desktop::AppFactory.get_app_component(
      app,
      {
        computer_id: @computer_id,
        args: args
      }
    )
    app_component = Desktop::AppComponent.new(component: component)

    @broadcaster.open_app(app_component)
  end

  def close(args)
  end
end
