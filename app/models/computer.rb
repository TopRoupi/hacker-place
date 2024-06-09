# == Schema Information
#
# Table name: computers
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Computer < ApplicationRecord
  has_many :v_files

  def self.default_pc
    order(:created_at).last
  end
end
