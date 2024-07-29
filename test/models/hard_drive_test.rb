# == Schema Information
#
# Table name: hard_drives
#
#  id                 :uuid             not null, primary key
#  capacity_megabytes :integer          not null
#  durability_loss    :float            not null
#  product_model_name :string           not null
#  socket_type        :integer          not null
#  speed_megabytes    :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  product_model_id   :string           not null
#
require "test_helper"

class HardDriveTest < ActiveSupport::TestCase
  test "should include buyable concern" do
    assert HardDrive.included_modules.include?(BuyableConcern)
  end
end
