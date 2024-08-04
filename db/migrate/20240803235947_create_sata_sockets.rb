class CreateSataSockets < ActiveRecord::Migration[7.1]
  def change
    create_table :sata_sockets, id: :uuid do |t|
      t.references :mother_board, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
