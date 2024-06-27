class TerminalChannel < ApplicationCable::Channel
  attr_accessor :read_io, :write_io
  attr_reader :terminal_broadcaster, :de_broadcaster

  def subscribed
    @computer_id = params["computerId"]
    @app_id = params["appId"]
    stream_for @app_id
  end

  def unsubscribed
    @cable_intrinsics_server.kill
  rescue DRb::DRbConnError
  end

  def input(args)
    str = args["input"]

    terminal_broadcaster.disable_input(str)

    @cable_intrinsics_server.receive_input(str)
  end

  def run(args)
    args.transform_keys(&:underscore).symbolize_keys => {app_id:, code:, params:}

    @terminal_broadcaster = Broadcast::Terminal.new(app_id, app_id)
    terminal_broadcaster.clear_terminal

    @lgo = Lgo.new(
      code,
      computer: Computer.find(@computer_id),
      params: params,
      intrinsics_args: {broadcaster: terminal_broadcaster}
    )

    pid = fork {
      @lgo.intrinsics.initialize_server
      @lgo.run
    }
    Process.detach(pid)

    DRb.start_service
    @cable_intrinsics_server = DRbObject.new_with_uri(@lgo.intrinsics.uri)
  end
end
