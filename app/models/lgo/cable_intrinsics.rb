class Lgo::CableIntrinsics
  include CableReady::Broadcaster
  include Lgo::Apis::File

  attr_reader :broadcaster

  def initialize(broadcaster:)
    @broadcaster = broadcaster
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
    # active_cable input uses a bunch of internals hacking
    # so the normal input command is not used
    # should probably fix it later.... TODO
    raise
  end

  def cmd_params(params)
    params
  end
end
