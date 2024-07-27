# == Schema Information
#
# Table name: hard_drives
#
#  id                    :uuid             not null, primary key
#  capacity_megabytes    :integer          not null
#  durability            :integer          not null
#  model_name            :string           not null
#  read_speed_megabytes  :integer          not null
#  socket_type           :integer          not null
#  write_speed_megabytes :integer          not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  model_id              :string           not null
#
require "test_helper"

class HardDriveTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
