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
class VProcessValidator < ActiveModel::Validator
  def validate(record)
    if record.dead? && record.ended_at.nil?
      record.errors.add :ended_at, "Dead process should have ended_at set"
    end
  end
end

class VProcess < ApplicationRecord
  validates_with VProcessValidator

  belongs_to :computer
  has_one :lgo_process

  enum :state, [:running, :dead]

  attribute :started_at, default: -> { Time.now }
  attribute :pid, default: -> { rand(9999).to_s }
end
