class Lgo::CableIntrinsics
  include CableReady::Broadcaster
  include Lgo::Apis::File

  attr_reader :broadcaster, :uri

  @@id = 99

  def initialize(lgo:, broadcaster:)
    @broadcaster = broadcaster
    @lgo = lgo

    @@id -= 1
    @uri = "druby://localhost:87#{@@id}"
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
end
