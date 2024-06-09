# == Schema Information
#
# Table name: v_processes
#
#  id          :uuid             not null, primary key
#  command     :string           not null
#  cpu_usage   :integer          default(0), not null
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
require "test_helper"

class VProcessTest < ActiveSupport::TestCase
  test "should create necessary default values" do
    p = VProcess.new
    assert_equal p.cpu_usage, 0
    assert_equal p.ram_usage, 0
    assert p.pid.size > 0
    refute p.started_at.nil?
  end
end
