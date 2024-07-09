class Lgo::CableIntrinsics
  include CableReady::Broadcaster
  include Lgo::Apis::Computer
  include Lgo::Apis::File

  attr_reader :broadcaster, :uri

  @@id = 999

  def initialize(lgo:, broadcaster:)
    @broadcaster = broadcaster
    @lgo = lgo

    @@id = 999 if @@id.zero?
    @@id -= 1
    @uri = "druby://localhost:9#{@@id}"
  end

  def initialize_server
    DRb.start_service(uri, self)
  end

  def cmd_print(*args)
    text = args.join(" ")

    broadcaster.print(text)

    "true"
  end

  def cmd_print_error(error)
    broadcaster.print_error(error)

    "true"
  end

  def cmd_input(str)
    broadcaster.enable_input(str)

    @received_input = false
    loop do
      sleep 0.5
      if @received_input == true
        break
      end
    end
    @input
  end

  def cmd_params(params)
    params
  end

  def receive_input(str)
    @received_input = true
    @input = str
  end

  def kill
    DRb.stop_service
    @lgo.kill
  end
end
