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
require "test_helper"

class LgoProcessTest < ActiveSupport::TestCase
  test "validations" do
    p = build :lgo_process
    p.code = nil
    p.save
    refute_empty p.errors[:code]
  end

  test "should be valid with waiting_to_run state and no control dates set" do
    p = build :lgo_process, state: "waiting_to_run"
    p.save

    assert_empty p.errors[:ended_at]
    assert_empty p.errors[:waited_at]
    assert_empty p.errors[:started_at]
  end

  test "should be invalid if in the dead state without an ended_at value" do
    p = LgoProcess.new(state: "dead")
    p.save

    refute_empty p.errors[:ended_at]
  end

  test "should be invalid if in the waiting state without an waited_at value" do
    p = LgoProcess.new(state: "waiting")
    p.save

    refute_empty p.errors[:waited_at]
  end

  test "should be invalid if in the running state without an started_at value" do
    p = LgoProcess.new(state: "running")
    p.save

    refute_empty p.errors[:started_at]
  end
end
