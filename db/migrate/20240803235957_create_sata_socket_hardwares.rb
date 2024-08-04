class CreateSataSocketHardwares < ActiveRecord::Migration[7.1]
  def change
    create_table :sata_socket_hardwares, id: :uuid do |t|
      t.references :mother_board_hardware, null: false, foreign_key: true, type: :uuid
      t.references :sata_socket, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
