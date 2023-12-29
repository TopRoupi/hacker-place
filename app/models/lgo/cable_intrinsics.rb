module Lgo::CableIntrinsics
  def cmd_print(*args)
    text = args.join(" ")

    cable_ready[TerminalChannel]
      .append(
        selector: "#run_stdout",
        html: "#{text}\n"
      )
      .broadcast_to("test")

    "true"
  end

  def cmd_print_error(error)
    cable_ready[TerminalChannel]
      .append(
        selector: "#run_stdout",
        html: "<span style='color: red'>#{error}</span>\n"
      )
      .broadcast_to("test")

    "true"
  end

  def cmd_input(str)
    # active_cable input uses a bunch of internals hacking
    # so the normal input command is not used
    # should probably fix it later.... TODO
    raise
  end
end
