# == Schema Information
#
# Table name: mother_board_hardwares
#
#  id              :uuid             not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  machine_id      :uuid             not null
#  mother_board_id :uuid             not null
#
# Indexes
#
#  index_mother_board_hardwares_on_machine_id       (machine_id)
#  index_mother_board_hardwares_on_mother_board_id  (mother_board_id)
#
# Foreign Keys
#
#  fk_rails_...  (machine_id => machines.id)
#  fk_rails_...  (mother_board_id => mother_boards.id)
#
FactoryBot.define do
  factory :mother_board_hardware do
    
  end
end
