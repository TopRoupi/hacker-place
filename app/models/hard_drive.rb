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
class HardDrive < ApplicationRecord
  self.implicit_order_column = "created_at"

  include BuyableConcern

  has_many :hard_drive_hardwares
  enum :socket_type, [:sata, :msata, :usb]

  validates :speed_megabytes, presence: true
  validates :capacity_megabytes, presence: true
  validates :socket_type, presence: true
end
