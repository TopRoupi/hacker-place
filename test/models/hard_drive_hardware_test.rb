# == Schema Information
#
# Table name: hard_drive_hardwares
#
#  id                       :uuid             not null, primary key
#  bootable                 :boolean          not null
#  connected_socket_type    :string
#  name                     :string           not null
#  path_mount_table         :jsonb
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  connected_socket_id      :uuid
#  hard_drive_id            :uuid             not null
#  mother_board_hardware_id :uuid             not null
#
# Indexes
#
#  idx_on_connected_socket_id_connected_socket_type_435eb5da67  (connected_socket_id,connected_socket_type)
#  index_hard_drive_hardwares_on_hard_drive_id                  (hard_drive_id)
#  index_hard_drive_hardwares_on_mother_board_hardware_id       (mother_board_hardware_id)
#
# Foreign Keys
#
#  fk_rails_...  (hard_drive_id => hard_drives.id)
#  fk_rails_...  (mother_board_hardware_id => mother_board_hardwares.id)
#
require "test_helper"

class HardDriveHardwareTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
