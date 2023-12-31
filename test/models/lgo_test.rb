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
end
