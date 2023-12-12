class TerminalChannel < ApplicationCable::Channel
  attr_accessor :read_io, :write_io
  def subscribed
    stream_for params[:id]
  end

  def receive(data)
    send("command_#{data["command"]}", data["args"])
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

    @read_io, @write_io = IO.pipe
    fork do
      system("./app/lgo/lgo", out: write_io, err: :out)
    end
    read_io.each_slice(2) do |lines|
      if lines.first[0..4] == "RUBY:"
        method, value = [lines.first.split(" ")[1], JSON.parse(lines.last)]
        p method, value

        case method
        when "print"
          client_stdout value.map { |i| i["value"] }.join(" ")
        when "print_error"
          client_stdout "\n" + value.first["value"]
        when "gets"
          puts "userinput"
        end
      end
    end
  end

  private

  def client_stdout(text)
    cable_ready[ApplicationChannel]
      .append(
        selector: "#run_stdout",
        html: text + "\n"
      )
      .broadcast_to("test")
  end
end
