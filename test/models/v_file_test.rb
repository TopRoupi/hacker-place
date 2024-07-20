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
require "test_helper"

class VFileTest < ActiveSupport::TestCase
  test "validations" do
    file = build :v_file
    file.name = ""
    file.save
    refute_empty file.errors[:name]

    file.name = "s"
    file.save
    assert_empty file.errors[:name]

    file.name = "s" * 100
    file.save
    assert_empty file.errors[:name]

    file.name = "s" * 101
    file.save
    refute_empty file.errors[:name]
  end

  test "should be invalid if name is not uniq inside the mahcine scope" do
    machine = create :machine
    create :v_file, machine: machine, name: "test"

    file = build :v_file, machine: machine, name: "test"
    file.save
    refute_empty file.errors[:name]
  end
end
