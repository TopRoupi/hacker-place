# == Schema Information
#
# Table name: lgo_processes
#
#  id            :uuid             not null, primary key
#  code          :string           not null
#  ended_at      :date
#  job_server_ip :string
#  pid           :string           not null
#  started_at    :date
#  state         :integer          default("waiting_to_run"), not null
#  tcp_port      :string
#  waited_at     :date
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  job_id        :string
#  v_process_id  :uuid             not null
#
# Indexes
#
#  index_lgo_processes_on_v_process_id  (v_process_id)
#
# Foreign Keys
#
#  fk_rails_...  (v_process_id => v_processes.id)
#
FactoryBot.define do
  factory :lgo_process do
    association :v_process
    pid { "1" }
    code { "print(2)" }
  end
end
