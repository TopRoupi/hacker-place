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
  include BuyableConcern
end
