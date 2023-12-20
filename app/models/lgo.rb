class Lgo
  attr_reader :write_io, :read_io
  attr_accessor :last_line, :last_cmd, :last_cmd_result, :code, :script_path

  def initialize(code)
    @code = code

    run_script(code)
  end

  def step_eval
    @exection_fiber.resume(self)
  end

  def send_result(*params)
    @write_io.printf("#{Lgo::ArgParser.dump(params)}\n")
  end

  def run
    loop do
      break if step_eval.nil?
      send_result last_cmd.run
    end
  end

  private

  def run_script(code)
    # TODO make the paths random
    @script_path = "/tmp/in.lua"
    f = File.open(@script_path, "w")
    f.puts code
    f.close

    @read_io, @write_io, @pid = PTY.spawn("./app/lgo/lgo #{@script_path}")

    @exection_fiber = Fiber.new do |lgo|
      loop do
        lgo.last_line = lgo.read_io.gets
        if Lgo::Cmd.is_cmd?(lgo.last_line)
          lgo.last_cmd = Lgo::Cmd.new(lgo)
          Fiber.yield lgo
        end
      rescue Errno::EIO
        break
      end
    end
  end
end
