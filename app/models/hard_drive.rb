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
class HardDrive < ApplicationRecord
  has_many :hard_drive_hardwares
  enum :socket_type, [:sata, :msata, :usb]
end
