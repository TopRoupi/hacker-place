class TerminalChannel < ApplicationCable::Channel
  attr_accessor :read_io, :write_io
  attr_reader :terminal_broadcaster, :de_broadcaster

  def subscribed
    @computer_id = params["computerId"]
    @app_id = params["appId"]
    stream_for @app_id
  end

  def unsubscribed
    puts "killing lgo", @lgo.pid
    p `kill #{@lgo.pid}`
  end

  def input(args)
    str = args["input"]

    terminal_broadcaster.disable_input(str)

    @lgoserver.receive_input(str)
  end

  def run(args)
    args.transform_keys(&:underscore).symbolize_keys => {app_id:, code:, params:}

    @terminal_broadcaster = Broadcast::Terminal.new(app_id, app_id)
    terminal_broadcaster.clear_terminal

    @lgo = Lgo.new(code, computer: Computer.find(@computer_id), params: params, intrinsics_args: {broadcaster: terminal_broadcaster})

    @lgo_fork = fork { @lgo.run }
    Process.detach(@lgo_fork)

    DRb.start_service
    @lgoserver = DRbObject.new_with_uri(@lgo.intrinsics.uri)
  rescue => error
    p error.message
    puts error.backtrace.join("\n")
  end
end
