# == Schema Information
#
# Table name: machines
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Machine < ApplicationRecord
  self.implicit_order_column = "created_at"

  has_many :v_files
  has_many :v_processes
  has_many :lgo_processes, through: :v_processes
end
