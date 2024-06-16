# == Schema Information
#
# Table name: v_processes
#
#  id          :uuid             not null, primary key
#  command     :string           not null
#  cpu_usage   :integer          default(0), not null
#  ended_at    :date
#  name        :string
#  pid         :string           not null
#  ram_usage   :integer          default(0), not null
#  started_at  :date             not null
#  state       :integer          default("running"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  computer_id :uuid             not null
#
# Indexes
#
#  index_v_processes_on_computer_id  (computer_id)
#
# Foreign Keys
#
#  fk_rails_...  (computer_id => computers.id)
#
FactoryBot.define do
  factory :v_process do
    association :computer
    cpu_usage { 0 }
    ram_usage { 0 }
    command { "lgo" }
  end
end
