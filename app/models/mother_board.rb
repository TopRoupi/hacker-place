# == Schema Information
#
# Table name: mother_boards
#
#  id         :uuid             not null, primary key
#  config     :jsonb            not null
#  durability :integer          not null
#  model_name :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  model_id   :string           not null
#
class MotherBoard < ApplicationRecord
end
