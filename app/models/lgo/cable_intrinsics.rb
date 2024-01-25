class Lgo::CableIntrinsics
  include CableReady::Broadcaster

  class << self
    include Lgo::Apis::File
  end

  def self.cmd_print(*args)
    text = args.join(" ")

    new.cable_ready[TerminalChannel]
      .append(
        selector: "#run_stdout",
        html: "#{text}\n"
      )
      .broadcast_to("test")

    "true"
  end

  def self.cmd_print_error(error)
    new.cable_ready[TerminalChannel]
      .append(
        selector: "#run_stdout",
        html: "<span style='color: red'>#{error}</span>\n"
      )
      .broadcast_to("test")

    "true"
  end

  def self.cmd_input(str)
    # active_cable input uses a bunch of internals hacking
    # so the normal input command is not used
    # should probably fix it later.... TODO
    raise
  end

  def self.cmd_params(params)
    params
  end
end
