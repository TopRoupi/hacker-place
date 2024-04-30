class TerminalChannel < ApplicationCable::Channel
  attr_accessor :read_io, :write_io
  attr_reader :terminal_broadcaster, :de_broadcaster

  def subscribed
    @computer_id = params["computerId"]
    @app_id = params["appId"]
    stream_for @app_id
  end

  def input(args)
    str = args["input"]
    @lgo.send_result(str)

    terminal_broadcaster.disable_input(str)

    exec_until_user_input
  end

  def run(args)
    args.transform_keys(&:underscore).symbolize_keys => {app_id:, code:, params:}

    @terminal_broadcaster = Broadcast::Terminal.new(app_id, app_id)
    terminal_broadcaster.clear_terminal

    @lgo = Lgo.new(code, params: params, intrinsics_args: {broadcaster: terminal_broadcaster})
    exec_until_user_input
  rescue => error
    p error.message
    puts error.backtrace.join("\n")
  end

  def exec_until_user_input
    loop do
      r = @lgo.step_eval
      return :end if r.nil?
      if r.last_cmd.cmd == "input"
        input_text = ""
        if @lgo.last_cmd.args.length > 0
          input_text = @lgo.last_cmd.args[0]["value"].to_s
        end

        terminal_broadcaster.enable_input(input_text)

        return :input
      end
      r.send_result(r.last_cmd.run)
    end
  end
end
