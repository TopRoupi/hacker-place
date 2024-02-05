class TerminalChannel < ApplicationCable::Channel
  attr_accessor :read_io, :write_io
  attr_reader :broadcaster

  def subscribed
    stream_for params[:id]

    @broadcaster = Broadcast::Terminal.new
  end

  def receive(data)
    send("command_#{data["command"]}", data["args"])
  end

  def command_input(str)
    @lgo.send_result(str[0])

    broadcaster.disable_input(str[0])

    exec_until_user_input
  end

  def command_run(args)
    code, params = args
    broadcaster.clear_terminal

    @lgo = Lgo.new(code, params: params)
    exec_until_user_input
  end

  def exec_until_user_input
    loop do
      r = @lgo.step_eval
      if r.last_cmd.cmd == "input"
        input_text = ""
        if @lgo.last_cmd.args.length > 0
          input_text = @lgo.last_cmd.args[0]["value"].to_s
        end

        broadcaster.enable_input(input_text)

        return :input
      end
      return :end if r.nil?
      r.send_result(r.last_cmd.run)
    end
  end
end
