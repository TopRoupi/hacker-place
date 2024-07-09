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

  def pre_cmd_getcomputer(args)
    @lgo.intrinsics.send(:cmd_getcomputer)
  end

  def pre_cmd_createfile(args)
    computer_sig, name, content = args.map { |o| o["value"] }
    computer = GlobalID::Locator.locate_signed computer_sig

    @lgo.intrinsics.send(:cmd_createfile, computer, name, content)
  end

  def pre_cmd_editfile(args)
    computer_sig, name, content = args.map { |o| o["value"] }
    computer = GlobalID::Locator.locate_signed computer_sig

    @lgo.intrinsics.send(:cmd_editfile, computer, name, content)
  end

  def pre_cmd_deletefile(args)
    computer_sig, name = args.map { |o| o["value"] }
    computer = GlobalID::Locator.locate_signed computer_sig

    @lgo.intrinsics.send(:cmd_deletefile, computer, name)
  end

  def pre_cmd_getfile(args)
    computer_sig, name = args.map { |o| o["value"] }
    computer = GlobalID::Locator.locate_signed computer_sig

    @lgo.intrinsics.send(:cmd_getfile, computer, name)
  end
end
