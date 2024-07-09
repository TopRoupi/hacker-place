class Lgo::UnitTestIntrinsics
  include Lgo::Apis::Computer
  include Lgo::Apis::File

  def initialize(lgo:)
    @lgo = lgo
    @out = ""
    @in = ""
  end

  attr_reader :out

  attr_writer :out

  attr_writer :in

  def cmd_print(*args)
    text = args.join(" ")
    write_to_out(text)
    "true"
  end

  def cmd_print_error(error)
    write_to_out(error)
    "true"
  end

  def cmd_input(str)
    if str
      write_to_out(str)
    end

    read_from_in
  end

  def cmd_params(params)
    params
  end

  private

  def write_to_out(str)
    @out += str + "\n"
  end

  def read_from_in
    r = @in.lines.first
    r = r[..-2] if r[-1] == "\n"
    @in = @in.lines[1...].join
    r
  end
end
