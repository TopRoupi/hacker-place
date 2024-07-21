class CreatePartitions < ActiveRecord::Migration[7.1]
  def change
    create_table :partitions, id: :uuid do |t|
      t.references :hard_drive_hardware, null: false, foreign_key: true, type: :uuid
      t.integer :size_megabytes, null: false
      t.integer :start_position, null: false
      t.integer :type, null: false
      t.boolean :bootable, null: false
      t.boolean :encrypted, null: false, default: false
      t.boolean :password, null: true
      # t.string :mount_path, null: false

      t.timestamps
    end
  end
end
