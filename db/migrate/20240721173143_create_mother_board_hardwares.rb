class CreateMotherBoardHardwares < ActiveRecord::Migration[7.1]
  def change
    create_table :mother_board_hardwares, id: :uuid do |t|
      t.references :machine, null: false, foreign_key: true, type: :uuid
      t.references :mother_board, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
