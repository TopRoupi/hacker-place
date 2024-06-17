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
#  index_v_files_on_computer_id           (computer_id)
#  index_v_files_on_name_and_computer_id  (name,computer_id) UNIQUE
#
FactoryBot.define do
  factory :v_file do
    association :computer
    content { "content" }
    name { "name" }
  end
end
