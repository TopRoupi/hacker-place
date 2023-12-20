module Lgo::TerminalIntrinsics
  def cmd_print(*args)
    text = args.join(" ")

    puts text

    "true"
  end

  def cmd_input(str)
    if str
      print str
    end

    gets
  end
end
