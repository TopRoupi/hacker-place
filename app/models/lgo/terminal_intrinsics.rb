class Lgo::TerminalIntrinsics
  def self.cmd_print(*args)
    text = args.join(" ")

    puts text

    "true"
  end

  def self.cmd_print_error(error)
    puts error

    "true"
  end

  def self.cmd_input(str)
    if str
      print str
    end

    gets
  end
end
