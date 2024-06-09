# == Schema Information
#
# Table name: lgo_processes
#
#  id            :uuid             not null, primary key
#  job_server_ip :string
#  pid           :string           not null
#  state         :integer          default("running"), not null
#  tcp_port      :string
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
  # test "the truth" do
  #   assert true
  # end
end
