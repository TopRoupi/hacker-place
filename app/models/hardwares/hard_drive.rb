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
class HardDrive < ApplicationRecord
  self.implicit_order_column = "created_at"

  include BuyableConcern

  has_many :hard_drive_hardwares
  enum :socket_type, [:sata, :msata, :usb]

  validates :speed_megabytes, presence: true
  validates :capacity_megabytes, presence: true
  validates :socket_type, presence: true
end
