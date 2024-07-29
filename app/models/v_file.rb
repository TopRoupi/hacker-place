# == Schema Information
#
# Table name: v_files
#
#  id         :uuid             not null, primary key
#  content    :string
#  name       :string
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  machine_id :uuid             not null
#
# Indexes
#
#  index_v_files_on_machine_id           (machine_id)
#  index_v_files_on_name_and_machine_id  (name,machine_id) UNIQUE
#
class VFile < ApplicationRecord
  self.implicit_order_column = "created_at"

  belongs_to :machine
  validates :name, uniqueness: {scope: :machine_id}, length: {minimum: 1, maximum: 100}
end
