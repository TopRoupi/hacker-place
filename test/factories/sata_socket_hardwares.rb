# == Schema Information
#
# Table name: sata_socket_hardwares
#
#  id                       :uuid             not null, primary key
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  mother_board_hardware_id :uuid             not null
#  sata_socket_id           :uuid             not null
#
# Indexes
#
#  index_sata_socket_hardwares_on_mother_board_hardware_id  (mother_board_hardware_id)
#  index_sata_socket_hardwares_on_sata_socket_id            (sata_socket_id)
#
# Foreign Keys
#
#  fk_rails_...  (mother_board_hardware_id => mother_board_hardwares.id)
#  fk_rails_...  (sata_socket_id => sata_sockets.id)
#
FactoryBot.define do
  factory :sata_socket_hardware do
    
  end
end
