require "test_helper"

class LgoTest < ActiveSupport::TestCase
  setup do
    @computer = Computer.create!
  end

  test "should create lgo_process in the set computer" do
    code = "print(4)"
    lgo = Lgo.new(code, computer: @computer, intrinsics: :unit_test)
    lgo.run
    @computer.reload
    assert_equal @computer.lgo_processes.count, 1
    assert_equal @computer.lgo_processes.last.state, "dead"
    assert_equal @computer.v_processes.last.state, "dead"
  end

  test "prints" do
    code = "print(4)"
    lgo = Lgo.new(code, computer: @computer, intrinsics: :unit_test)

    lgo.run
    assert_equal lgo.intrinsics.out, "4\n"
  end

  test "print variables" do
    code = <<~EOS
      a = 2
      print(a + 1)
    EOS

    lgo = Lgo.new(code, computer: @computer, intrinsics: :unit_test)
    lgo.run

    assert_equal lgo.intrinsics.out, "3\n"
  end

  test "print syntax errors" do
    code = <<~EOS
      a = 2
      d..
    EOS

    lgo = Lgo.new(code, computer: @computer, intrinsics: :unit_test)
    lgo.run

    assert lgo.intrinsics.out.include? "parse error"
  end

  test "take values from input" do
    code = <<~EOS
      a = tonumber(input(""))
      b = tonumber(input(""))
      print(a + b)
    EOS

    lgo = Lgo.new(code, computer: @computer, intrinsics: :unit_test)
    lgo.intrinsics.in = "5\n3\n"
    lgo.run

    assert lgo.intrinsics.out.include? "8"
  end

  test "input should work without params" do
    code = <<~EOS
      a = input()
      print(a)
    EOS

    lgo = Lgo.new(code, computer: @computer, intrinsics: :unit_test)
    lgo.intrinsics.in = "ttt"
    lgo.run

    assert lgo.intrinsics.out.include? "ttt"
  end

  test "params should be set inside the lua state" do
    code = <<~EOS
      for i = 0, #params do
        print(params[i])
      end
    EOS

    lgo = Lgo.new(code, computer: @computer, params: "-v --lol", intrinsics: :unit_test)
    lgo.run

    assert lgo.intrinsics.out.include? "-v"
    assert lgo.intrinsics.out.include? "--lol"
  end

  test "createfile should create a new file" do
    code = <<~EOS
      createfile("test", "111")
    EOS

    lgo = Lgo.new(code, computer: @computer, intrinsics: :unit_test)
    lgo.run

    assert_equal @computer.v_files.count, 1
    assert_equal @computer.v_files.last.name, "test"
    assert_equal @computer.v_files.last.content, "111"

    code = <<~EOS
      createfile("test", "111")
    EOS

    lgo = Lgo.new(code, computer: @computer, intrinsics: :unit_test)
    lgo.run

    assert_equal @computer.v_files.count, 1
    assert lgo.intrinsics.out.include? "ERROR"
  end

  test "editfile should edit the file with the same name" do
    file = VFile.create(name: "test", content: "111", computer: @computer)

    code = <<~EOS
      editfile("test", "222")
    EOS

    lgo = Lgo.new(code, computer: @computer, intrinsics: :unit_test)
    lgo.run

    file.reload

    assert_equal file.content, "222"
  end

  test "deletefile should delete the file with the same name" do
    VFile.create(name: "test", content: "111", computer: @computer)

    code = <<~EOS
      deletefile("test")
    EOS

    file_count_before = VFile.count

    lgo = Lgo.new(code, computer: @computer, intrinsics: :unit_test)
    lgo.run

    assert_equal VFile.count, file_count_before - 1
  end

  test "deletefile should error if file does not exist" do
    code = <<~EOS
      deletefile("lllllll")
    EOS

    lgo = Lgo.new(code, computer: @computer, intrinsics: :unit_test)
    lgo.run

    assert lgo.intrinsics.out.include? "ERROR"
  end

  test "getfile should get the content the file with the same name" do
    VFile.create(name: "test", content: "111", computer: @computer)

    code = <<~EOS
      print(getfile("test"))
    EOS

    lgo = Lgo.new(code, computer: @computer, intrinsics: :unit_test)
    lgo.run

    assert lgo.intrinsics.out.include? "111"
  end
end
