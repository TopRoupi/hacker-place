# == Schema Information
#
# Table name: hard_drive_hardwares
#
#  id                       :uuid             not null, primary key
#  bootable                 :boolean          not null
#  name                     :string           not null
#  path_mount_table         :jsonb
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  hard_drive_id            :uuid             not null
#  mother_board_hardware_id :uuid             not null
#
# Indexes
#
#  index_hard_drive_hardwares_on_hard_drive_id             (hard_drive_id)
#  index_hard_drive_hardwares_on_mother_board_hardware_id  (mother_board_hardware_id)
#
# Foreign Keys
#
#  fk_rails_...  (hard_drive_id => hard_drives.id)
#  fk_rails_...  (mother_board_hardware_id => mother_board_hardwares.id)
#
FactoryBot.define do
  factory :hard_drive_hardware do
    
  end
end
