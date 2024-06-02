require "test_helper"

class PlayerTest < ActiveSupport::TestCase
  test "should create a computer before create" do
    player = Player.create(email: "lol@lol", password: "123456")

    player.reload
    refute_nil player.computer
  end
end
