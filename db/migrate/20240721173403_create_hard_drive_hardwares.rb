class CreateHardDriveHardwares < ActiveRecord::Migration[7.1]
  def change
    create_table :hard_drive_hardwares, id: :uuid do |t|
      t.references :hard_drive, null: false, foreign_key: true, type: :uuid
      t.references :mother_board_hardware, null: false, foreign_key: true, type: :uuid
      # t.jsonb :partition_table

      t.timestamps
    end
  end
end
