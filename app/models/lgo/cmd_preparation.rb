module Lgo::CmdPreparation
  def pre_cmd_print(args)
    args = args.map { |o| o["value"] }

    send(:cmd_print, args)
    # text = args.map { |i| i["value"] }.join(" ")
    #
    # puts text
    #
    # cable_ready[TerminalChannel]
    #   .append(
    #     selector: "#run_stdout",
    #     html: "#{text}\n"
    #   )
    #   .broadcast_to("test")
    #
    # "true"
  end

  def pre_cmd_input(args)
    # print args[0]["value"]
    # gets

    # logic for this command is splattered all over
    # this api should be refactored
    # if args.length > 0
    #   print args[0]["value"]
    # end
    #
    # gets
    str = if args.length > 0
      args[0]["value"]
    end

    send(:cmd_input, str)
  end
end
