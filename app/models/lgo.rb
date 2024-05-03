class Lgo
  attr_reader :write_io, :read_io, :pid
  attr_reader :intrinsics

  attr_accessor :code, :params, :script_path
  attr_accessor :last_line, :last_cmd, :last_cmd_result

  @@intrinsics = {
    terminal: Lgo::TerminalIntrinsics,
    cable: Lgo::CableIntrinsics,
    unit_test: Lgo::UnitTestIntrinsics
  }

  def initialize(code, params: "", intrinsics: :cable, intrinsics_args: {})
    @code = code
    @params = params
    @intrinsics = @@intrinsics[intrinsics].new(**intrinsics_args)

    run_script(code)
  end

  def step_eval
    @exection_fiber.resume(self)
  end

  def send_result(*params)
    @write_io.printf("->#{Lgo::ArgParser.dump(params)}\n")
  end

  def run
    if @intrinsics.instance_of?(@@intrinsics[:cable])
      @intrinsics.initialize_server
    end
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

    fork { exec("cpulimit -p #{@pid} --limit 5") }

    @exection_fiber = Fiber.new do |lgo|
      loop do
        last_line = lgo.read_io.gets
        if last_line[0...2] == "->"
          lgo.last_line = last_line[2..]
        else
          puts "go: #{last_line}"
          next
        end

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
