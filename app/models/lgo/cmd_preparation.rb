module Lgo::CmdPreparation
  def pre_cmd_print(args)
    args = args.map { |o| o["value"] }

    send(:cmd_print, args)
  end

  def pre_cmd_print_error(args)
    send(:cmd_print_error, args[0]["value"])
  end

  def pre_cmd_input(args)
    str = if args.length > 0
      args[0]["value"]
    end

    send(:cmd_input, str)
  end
end
