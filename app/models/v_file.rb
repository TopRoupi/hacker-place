# == Schema Information
#
# Table name: v_files
#
#  id          :uuid             not null, primary key
#  content     :string
#  name        :string
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  computer_id :uuid             not null
#
# Indexes
#
#  index_v_files_on_computer_id  (computer_id)
#
class VFile < ApplicationRecord
  belongs_to :computer
end
