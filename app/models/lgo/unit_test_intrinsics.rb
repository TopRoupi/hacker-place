class Lgo::UnitTestIntrinsics
  @@out = ""
  class << self
    def out
      @@out
    end

    def out=(str)
      @@out = str
    end

    def cmd_print(*args)
      text = args.join(" ")

      @@out << text + "\n"

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
  end
end
