require "test_helper"

class LgoTest < ActiveSupport::TestCase
  test "prints" do
    code = "print(4)"
    lgo = Lgo.new(code, intrinsics: :unit_test)

    lgo.run
    assert_equal lgo.intrinsics.out, "4\n"
  end

  test "print variables" do
    code = <<~EOS
      a = 2
      print(a + 1)
    EOS

    lgo = Lgo.new(code, intrinsics: :unit_test)
    lgo.run

    assert_equal lgo.intrinsics.out, "3\n"
  end

  test "print syntax errors" do
    code = <<~EOS
      a = 2
      d..
    EOS

    lgo = Lgo.new(code, intrinsics: :unit_test)
    lgo.run

    assert lgo.intrinsics.out.include? "parse error"
  end

  test "print input message" do
    code = <<~EOS
      print("enter number")
    EOS

    lgo = Lgo.new(code, intrinsics: :unit_test)
    lgo.run

    assert lgo.intrinsics.out.include? "enter number"
  end

  test "take values from input" do
    code = <<~EOS
      a = tonumber(input(""))
      b = tonumber(input(""))
      print(a + b)
    EOS

    lgo = Lgo.new(code, intrinsics: :unit_test)
    lgo.intrinsics.in = "5\n3\n"
    lgo.run

    assert lgo.intrinsics.out.include? "8"
  end

  test "input should work without params" do
    code = <<~EOS
      a = input()
      print(a)
    EOS

    lgo = Lgo.new(code, intrinsics: :unit_test)
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

    lgo = Lgo.new(code, params: "-v --lol", intrinsics: :unit_test)
    lgo.run

    assert lgo.intrinsics.out.include? "-v"
    assert lgo.intrinsics.out.include? "--lol"
  end
end
