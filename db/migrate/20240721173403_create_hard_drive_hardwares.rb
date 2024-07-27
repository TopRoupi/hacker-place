class CreateHardDriveHardwares < ActiveRecord::Migration[7.1]
  def change
    create_table :hard_drive_hardwares, id: :uuid do |t|
      t.references :hard_drive, null: false, foreign_key: true, type: :uuid
      t.references :mother_board_hardware, null: false, foreign_key: true, type: :uuid
      t.boolean :bootable, null: false
      t.jsonb :path_mount_table
      t.string :name, null: false

      t.timestamps
    end
  end
end
