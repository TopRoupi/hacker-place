require "socket"

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

    server = TCPServer.new(8069)

    pid = Process.fork
    if pid.nil?
      exec "./app/lgo/lgo"
    else
      Process.detach(pid)
    end

    loop do
      client = server.accept

      data = client.gets
      break if data == "END\n"


      cable_ready[ApplicationChannel]
        .append(
          selector: "#run_stdout",
          html: data
        )
        .broadcast_to("test")
      puts data

      client.close
    end

    server.close
  end
end
