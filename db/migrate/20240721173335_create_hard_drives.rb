class CreateHardDrives < ActiveRecord::Migration[7.1]
  def change
    create_table :hard_drives, id: :uuid do |t|
      t.integer :capacity_megabytes, null: false
      t.integer :read_speed_megabytes, null: false
      t.integer :write_speed_megabytes, null: false
      t.integer :durability, null: false

      t.timestamps
    end
  end
end
