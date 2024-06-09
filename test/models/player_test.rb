# == Schema Information
#
# Table name: players
#
#  id              :uuid             not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  verified        :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  computer_id     :uuid
#
# Indexes
#
#  index_players_on_computer_id  (computer_id)
#  index_players_on_email        (email) UNIQUE
#
require "test_helper"

class PlayerTest < ActiveSupport::TestCase
  test "should create a computer before create" do
    player = Player.create(email: "lol@lol", password: "123456")

    player.reload
    refute_nil player.computer
  end
end
