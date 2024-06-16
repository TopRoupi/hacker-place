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
class LgoProcessValidator < ActiveModel::Validator
  def validate(record)
    if record.running? && record.started_at.nil?
      record.errors.add :started_at, "Running process should have started_at set"
    end

    if record.waiting? && record.waited_at.nil?
      record.errors.add :waited_at, "Waiting process should have waited_at set"
    end

    if record.dead? && record.ended_at.nil?
      record.errors.add :ended_at, "Dead process should have ended_at set"
    end
  end
end

class LgoProcess < ApplicationRecord
  validates_with LgoProcessValidator

  belongs_to :v_process
  enum :state, [:waiting_to_run, :running, :dead, :waiting]
  validates :code, presence: true
end
