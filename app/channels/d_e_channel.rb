class DEChannel < ApplicationCable::Channel
  def subscribed
    @computer_id = params["computerId"]
    puts @computer_id
    stream_for @computer_id

    @broadcaster = Broadcast::Ide.new(@app_id)
  end

  def receive(data)
    send("command_#{data["command"]}", data["args"])
  end

  def command_open(args)
  end

  def command_close(args)
  end
end
