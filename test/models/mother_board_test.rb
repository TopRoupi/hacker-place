# == Schema Information
#
# Table name: mother_boards
#
#  id         :uuid             not null, primary key
#  config     :jsonb            not null
#  durability :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class MotherBoardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
