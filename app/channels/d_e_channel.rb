class DEChannel < ApplicationCable::Channel
  def subscribed
    @computer_id = params["computerId"]
    stream_for @computer_id

    @broadcaster = Broadcast::DE.new(@computer_id)
  end

  def receive(data)
    send(:"command_#{data["command"]}", data["args"])
  end

  def command_open(args)
    # HACK opening terminal is hard coded
    # the app should be generated using the args
    component = Desktop::AppFactory.get_app_component(
      :terminal, {
        computer_id: @computer_id,
        code: args[1]["code"],
        args: args[1]["args"]
      }
    )
    app_component = Desktop::AppComponent.new(component: component)

    @broadcaster.open_app(app_component)
  end

  def command_close(args)
  end
end
