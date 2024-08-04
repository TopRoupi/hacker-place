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
class MotherBoard < ApplicationRecord
  self.implicit_order_column = "created_at"

  include BuyableConcern

  validates :config, presence: true

  # has_many :sata_socktes
  # has_many :usb_socktes
  # ...
  Dir.entries("#{Rails.root}/app/models/hardwares/sockets").each do |file|
    if file[-9..] == "socket.rb"
      has_many file.split(".").first.pluralize.to_sym
    end
  end

  # return the list of available sockets for this model
  def sockets
  end
end
