require "json"

class RunProcessJob
  include Sidekiq::Job
  include CableReady::Broadcaster
  include Rails.application.routes.url_helpers
  delegate :render, to: :ApplicationController

  def perform(code)
    cable_ready[ApplicationChannel]
      .inner_html(
        selector: "#run_stdout",
        html: ""
      )
      .broadcast_to("test")
    f = File.open("app/lgo/in.lua", "w")
    f.puts code
    f.close

    read_io, write_io = IO.pipe
    fork do
      system("./app/lgo/lgo", out: write_io, err: :out)
    end
    write_io.close
    read_io.each_slice(2) do |lines|
      if lines.first[0..4] == "RUBY:"
        method, value = [lines.first.split(" ")[1], JSON.parse(lines.last)]
        p method, value

        case method
        when "print"
          client_stdout value.map { |i| i["value"] }.join(" ")
        when "print_error"
          client_stdout "\n" + value.first["value"]
        end
      end
    end
  end

  private

  def client_stdout(text)
    cable_ready[ApplicationChannel]
      .append(
        selector: "#run_stdout",
        html: text
      )
      .broadcast_to("test")
  end
end
