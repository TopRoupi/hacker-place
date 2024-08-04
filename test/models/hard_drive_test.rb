# == Schema Information
#
# Table name: hard_drives
#
#  id                 :uuid             not null, primary key
#  capacity_megabytes :integer          not null
#  durability_loss    :float            not null
#  product_model_name :string           not null
#  socket_type        :string           not null
#  speed_megabytes    :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  product_model_id   :string           not null
#  socket_id          :uuid             not null
#
# Indexes
#
#  index_hard_drives_on_socket_type_and_socket_id  (socket_type,socket_id)
#
require "test_helper"

class HardDriveTest < ActiveSupport::TestCase
  test "should include buyable concern" do
    assert HardDrive.included_modules.include?(BuyableConcern)
  end
end
