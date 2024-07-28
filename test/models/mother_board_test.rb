# == Schema Information
#
# Table name: mother_boards
#
#  id                 :uuid             not null, primary key
#  config             :jsonb            not null
#  durability_loss    :float            not null
#  product_model_name :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  product_model_id   :string           not null
#
require "test_helper"

class MotherBoardTest < ActiveSupport::TestCase
  test "should include buyable concern" do
    assert MotherBoard.included_modules.include?(BuyableConcern)
  end
end
