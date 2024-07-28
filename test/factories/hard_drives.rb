# == Schema Information
#
# Table name: hard_drives
#
#  id                    :uuid             not null, primary key
#  capacity_megabytes    :integer          not null
#  durability_loss       :float            not null
#  product_model_name    :string           not null
#  read_speed_megabytes  :integer          not null
#  socket_type           :integer          not null
#  write_speed_megabytes :integer          not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  product_model_id      :string           not null
#
FactoryBot.define do
  factory :hard_drive do
    durability_loss { 0.001 }
    product_model_id { SecureRandom.uuid }
    product_model_name { "mother board #{product_model_id}" }
  end
end
