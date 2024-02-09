class Lgo::TerminalIntrinsics
  def cmd_print(*args)
    text = args.join(" ")

    puts text

    "true"
  end

  def cmd_print_error(error)
    puts error

    "true"
  end

  def cmd_input(str)
    if str
      print str
    end

    gets
  end

  def cmd_params(params)
    params
  end
end
