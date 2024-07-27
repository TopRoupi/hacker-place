class CreatePartitions < ActiveRecord::Migration[7.1]
  def change
    create_table :partitions, id: :uuid do |t|
      t.references :hard_drive_hardware, null: false, foreign_key: true, type: :uuid
      t.integer :size_megabytes, null: false
      t.integer :start_position, null: false
      t.integer :type, null: false
      t.boolean :bootable, null: false
      t.string :encryption_password
      t.boolean :password, null: true

      t.timestamps
    end
  end
end
