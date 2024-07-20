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
FactoryBot.define do
  factory :v_file do
    association :machine
    content { "content" }
    name { "name" }
  end
end
