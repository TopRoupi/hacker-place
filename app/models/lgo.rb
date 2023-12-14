require "json"
require "pty"

class Cmd
  include CableReady::Broadcaster

  attr_reader :id, :cmd, :args, :lgo

  def initialize(lgo)
    @lgo = lgo
    @id, @cmd = lgo.last_line.split(" ")
    @args = JSON.parse(lgo.last_line.split(" ")[2..].join(" "))
  end

  def run
    send("cmd_#{cmd}", args)
  end

  def self.is_cmd?(text)
    text[0..3] == "RUBY"
  end

  def cmd_print(args)
    text = args.map { |i| i["value"] }.join(" ")

    cable_ready[TerminalChannel]
      .append(
        selector: "#run_stdout",
        html: "#{text}\n"
      )
      .broadcast_to("test")

    "true"
  end

  def cmd_input(args)
    cable_ready[TerminalChannel]
      .inner_html(
        selector: "#stdin_status",
        html: "waiting for input: "
      )
      .broadcast_to("test")

    # puts args[0]["value"]
    puts "LLLLLLLLLLLLLLLLLLLLLLLLLLLLL"
    # gets
    "2"
  end
end

class Lgo
  attr_reader :write_io, :read_io
  attr_accessor :last_line, :last_cmd, :last_cmd_result

  def initialize
    @read_io, @write_io, @pid = PTY.spawn("./app/lgo/lgo")

    @exection_fiber = Fiber.new do |lgo|
      loop do
        lgo.last_line = lgo.read_io.gets
        if Cmd.is_cmd?(lgo.last_line)
          lgo.last_cmd = Cmd.new(lgo)
          Fiber.yield lgo
        end
      rescue Errno::EIO
        break
      end
    end
  end

  def step_eval
    @exection_fiber.resume(self)
  end

  def send_result(str)
    @write_io.printf("#{str}\n")
  end
end
