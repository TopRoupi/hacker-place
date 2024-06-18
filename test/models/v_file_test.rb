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
  end

  test "should be invalid if name is not uniq inside the computer scope" do
    computer = create :computer
    create :v_file, computer: computer, name: "test"

    file = build :v_file, computer: computer, name: "test"
    file.save
    refute_empty file.errors[:name]
  end
end
