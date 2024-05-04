module Lgo::CmdPreparation
  def pre_cmd_print(args)
    args = args.map { |o| o["value"] }

    @lgo.intrinsics.send(:cmd_print, args)
  end

  def pre_cmd_print_error(args)
    @lgo.intrinsics.send(:cmd_print_error, args[0]["value"])
  end

  def pre_cmd_input(args)
    str = if args.length > 0
      args[0]["value"]
    end

    @lgo.intrinsics.send(:cmd_input, str)
  end

  def pre_cmd_params(args)
    @lgo.intrinsics.send(:cmd_params, @lgo.params)
  end

  def pre_cmd_createfile(args)
    name, content = args.map { |o| o["value"] }

    @lgo.intrinsics.send(:cmd_createfile, name, content)
  end

  def pre_cmd_editfile(args)
    name, content = args.map { |o| o["value"] }

    @lgo.intrinsics.send(:cmd_editfile, name, content)
  end

  def pre_cmd_deletefile(args)
    @lgo.intrinsics.send(:cmd_deletefile, args[0]["value"])
  end

  def pre_cmd_getfile(args)
    @lgo.intrinsics.send(:cmd_getfile, args[0]["value"])
  end
end
