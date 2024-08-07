require "test_helper"

class LgoTest < ActiveSupport::TestCase
  setup do
    @machine = Machine.create!
  end

  test "should create lgo_process in the set machine" do
    code = "print(4)"
    lgo = Lgo.new(code, machine: @machine, intrinsics: :unit_test)

    @machine.reload
    assert_equal 1, @machine.lgo_processes.count
    assert_equal "waiting", @machine.lgo_processes.last.state
    assert_equal "waiting", @machine.v_processes.last.state

    lgo.run

    assert_equal 1, @machine.lgo_processes.count
    assert_equal "dead", @machine.lgo_processes.last.state
    assert_equal "dead", @machine.v_processes.last.state
  end

  #
  # test "should be kill running scripts" do
  #   code = <<~EOS
  #     while true do
  #     end
  #   EOS
  #
  #   broadcaster = Broadcast::Terminal.new("uwu", "uwu")
  #   lgo = Lgo.new(
  #     code,
  #     computer: @computer,
  #     intrinsics: :cable,
  #     intrinsics_args: {broadcaster: broadcaster}
  #   )
  #
  #   assert_equal 1, @computer.lgo_processes.count
  #   assert_equal "waiting", @computer.lgo_processes.last.state
  #   assert_equal "waiting", @computer.v_processes.last.state
  #
  #   pid = fork {
  #     lgo.intrinsics.initialize_server
  #     lgo.run
  #   }
  #   Process.detach(pid)
  #
  #   # sleep 5
  #   # assert_equal 1, @computer.lgo_processes.count
  #   # assert_equal "running", @computer.lgo_processes.last.state
  #   # assert_equal "running", @computer.v_processes.last.state
  #
  #   DRb.start_service
  #   cable_intrinsics_server = DRbObject.new_with_uri(lgo.intrinsics.uri)
  #
  #   cable_intrinsics_server.kill
  #
  #   assert_equal 1, @computer.lgo_processes.count
  #   assert_equal "dead", @computer.lgo_processes.last.state
  #   assert_equal "dead", @computer.v_processes.last.state
  # end

  test "should be able to step run" do
    code = <<~EOS
      print("1")
      print("2")
      print("3")
    EOS

    lgo = Lgo.new(code, machine: @machine, intrinsics: :unit_test)

    @machine.reload
    assert_equal 1, @machine.lgo_processes.count
    assert_equal "waiting", @machine.lgo_processes.last.state
    assert_equal "waiting", @machine.v_processes.last.state

    lgo.run(steps: true) # setting up params
    # assert_equal 1, @machine.lgo_processes.count
    # assert_equal "sleeping", @machine.lgo_processes.last.state
    # assert_equal "sleeping", @machine.v_processes.last.state

    lgo.run(steps: true)
    assert_equal "1\n", lgo.intrinsics.out

    lgo.run(steps: true)
    assert_equal "1\n2\n", lgo.intrinsics.out

    lgo.run(steps: true)
    assert_equal "1\n2\n3\n", lgo.intrinsics.out

    lgo.run(steps: true) # should kill process
    assert_equal "1\n2\n3\n", lgo.intrinsics.out
    assert_equal 1, @machine.lgo_processes.count
    assert_equal "dead", @machine.lgo_processes.last.state
    assert_equal "dead", @machine.v_processes.last.state

    assert_raises do
      lgo.run(steps: true)
    end

    assert_equal 1, @machine.lgo_processes.count
    assert_equal "dead", @machine.lgo_processes.last.state
    assert_equal "dead", @machine.v_processes.last.state
  end

  test "prints" do
    code = "print(4)"
    lgo = Lgo.new(code, machine: @machine, intrinsics: :unit_test)

    lgo.run
    assert_equal lgo.intrinsics.out, "4\n"
  end

  test "print variables" do
    code = <<~EOS
      a = 2
      print(a + 1)
    EOS

    lgo = Lgo.new(code, machine: @machine, intrinsics: :unit_test)
    lgo.run

    assert_equal lgo.intrinsics.out, "3\n"
  end

  test "print syntax errors" do
    code = <<~EOS
      a = 2
      d..
    EOS

    lgo = Lgo.new(code, machine: @machine, intrinsics: :unit_test)
    lgo.run

    assert lgo.intrinsics.out.include? "parse error"
  end

  test "take values from input" do
    code = <<~EOS
      a = tonumber(input(""))
      b = tonumber(input(""))
      print(a + b)
    EOS

    lgo = Lgo.new(code, machine: @machine, intrinsics: :unit_test)
    lgo.intrinsics.in = "5\n3\n"
    lgo.run

    assert lgo.intrinsics.out.include? "8"
  end

  test "input should work without params" do
    code = <<~EOS
      a = input()
      print(a)
    EOS

    lgo = Lgo.new(code, machine: @machine, intrinsics: :unit_test)
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

    lgo = Lgo.new(code, machine: @machine, params: "-v --lol", intrinsics: :unit_test)
    lgo.run

    assert lgo.intrinsics.out.include? "-v"
    assert lgo.intrinsics.out.include? "--lol"
  end

  test "createfile should create a new file" do
    code = <<~EOS
      c = get_computer()
      createfile(c, "test", "111")
    EOS

    lgo = Lgo.new(code, machine: @machine, intrinsics: :unit_test)
    lgo.run

    assert_equal @machine.v_files.count, 1
    assert_equal @machine.v_files.last.name, "test"
    assert_equal @machine.v_files.last.content, "111"

    lgo = Lgo.new(code, machine: @machine, intrinsics: :unit_test)
    lgo.run

    assert_equal @machine.v_files.count, 1
    assert lgo.intrinsics.out.include? "ERROR"
  end

  test "editfile should edit the file with the same name" do
    file = VFile.create(name: "test", content: "111", machine: @machine)

    code = <<~EOS
      c = get_computer()
      editfile(c, "test", "222")
    EOS

    lgo = Lgo.new(code, machine: @machine, intrinsics: :unit_test)
    lgo.run

    file.reload

    assert_equal "222", file.content
  end

  test "deletefile should delete the file with the same name" do
    VFile.create(name: "test", content: "111", machine: @machine)

    code = <<~EOS
      c = get_computer()
      deletefile(c, "test")
    EOS

    assert_difference("VFile.count", -1) do
      lgo = Lgo.new(code, machine: @machine, intrinsics: :unit_test)
      lgo.run
    end
  end

  test "deletefile should error if file does not exist" do
    code = <<~EOS
      c = get_computer()
      deletefile(c, "lllllll")
    EOS

    lgo = Lgo.new(code, machine: @machine, intrinsics: :unit_test)
    lgo.run

    assert lgo.intrinsics.out.include? "ERROR"
  end

  test "getfile should get the content the file with the same name" do
    VFile.create(name: "test", content: "111", machine: @machine)

    code = <<~EOS
      c = get_computer()
      print(getfile(c, "test"))
    EOS

    lgo = Lgo.new(code, machine: @machine, intrinsics: :unit_test)
    lgo.run

    assert lgo.intrinsics.out.include? "111"
  end
end
