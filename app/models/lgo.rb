class Lgo
  attr_reader :write_io, :read_io, :pid
  attr_reader :intrinsics
  attr_reader :verbose
  attr_reader :computer

  attr_accessor :code, :params, :script_path
  attr_accessor :last_line, :last_cmd, :last_cmd_result

  @@intrinsics = {
    terminal: Lgo::TerminalIntrinsics,
    cable: Lgo::CableIntrinsics,
    unit_test: Lgo::UnitTestIntrinsics
  }

  def initialize(code, computer:, params: "", intrinsics: :cable, intrinsics_args: {}, verbose: true)
    @verbose = Rails.env.test? ? false : verbose
    @code = code
    @params = params
    @computer = computer

    intrinsics_args[:lgo] = self
    @intrinsics = @@intrinsics[intrinsics].new(**intrinsics_args)

    initiate_lua_script(code)

    puts "lgo running on pid #{@pid}"
  end

  def verbose? = verbose

  def step_eval
    @exection_fiber.resume(self)
  end

  def send_result(*params)
    @write_io.printf("->#{Lgo::ArgParser.dump(params)}\n")
  end

  def run
    setup

    # TODO: there should be a better place to run this
    if intrinsics.instance_of?(@@intrinsics[:cable])
      intrinsics.initialize_server
    end

    while step_eval.nil? == false
      send_result last_cmd.run
    end

    cleanup
  end

  def kill
    puts "killing lgo", @pid
    p `kill #{@pid}`
    cleanup
  end

  private

  def setup
    @v_process = VProcess.new.tap do |p|
      p.computer = @computer
      p.command = "lgoscript"
      p.name = "lgoscript"
      p.lgo_process = LgoProcess.new(pid: @pid)
    end
    @v_process.save!
  end

  def cleanup
    @v_process.update(state: "dead")
    @v_process.lgo_process.update(state: "dead")
  end

  def initiate_lua_script(code)
    # TODO make the paths random
    @script_path = "/tmp/in.lua"
    f = File.open(@script_path, "w")
    f.puts code
    f.close

    @read_io, @write_io, @pid = PTY.spawn("./app/lgo/lgo #{@script_path}")

    fork { `cpulimit -p #{@pid} --limit 1` }

    @exection_fiber = Fiber.new do |lgo|
      loop do
        last_line = lgo.read_io.gets
        if last_line[0...2] == "->"
          puts last_line if verbose?
          lgo.last_line = last_line[2..]
        else
          puts "go: #{last_line}" if verbose?
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
