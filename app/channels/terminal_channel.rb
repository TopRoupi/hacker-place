class TerminalChannel < ApplicationCable::Channel
  attr_accessor :read_io, :write_io
  def subscribed
    stream_for params[:id]
  end

  def receive(data)
    send("command_#{data["command"]}", data["args"])
  end

  def command_input(str)
    @lgo.send_result(str[0])

    cable_ready[TerminalChannel]
      .append(
        selector: "#run_stdout",
        html: "#{str[0]}\n"
      )
      .inner_html(
        selector: "#stdin_status",
        html: ""
      )
      .set_attribute(
        name: "disabled",
        value: "",
        selector: "#run_stdin"
      )
      .set_value(
        name: "disabled",
        value: "",
        selector: "#run_stdin"
      )
      .set_attribute(
        name: "disabled",
        value: "",
        selector: "#run_stdin_btn"
      )
      .broadcast_to("test")

    exec_until_user_input
  end

  def command_run(code)
    cable_ready[TerminalChannel]
      .inner_html(
        selector: "#run_stdout",
        html: ""
      )
      .broadcast_to("test")

    f = File.open("app/lgo/in.lua", "w")
    f.puts code
    f.close

    @lgo = Lgo.new
    exec_until_user_input
  end

  def exec_until_user_input
    loop do
      r = @lgo.step_eval
      if r.last_cmd.cmd == "input"
        cable_ready[TerminalChannel]
          .append(
            selector: "#run_stdout",
            html: @lgo.last_cmd.args[0]["value"].to_s
          )
          .inner_html(
            selector: "#stdin_status",
            html: "waiting for input: "
          )
          .remove_attribute(
            name: "disabled",
            selector: "#run_stdin"
          )
          .remove_attribute(
            name: "disabled",
            selector: "#run_stdin_btn"
          )
          .broadcast_to("test")

        return :input
      end
      return :end if r.nil?
      r.send_result(r.last_cmd.run)
    end
  end
end
