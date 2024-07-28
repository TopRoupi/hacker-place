class CreateMotherBoards < ActiveRecord::Migration[7.1]
  def change
    create_table :mother_boards, id: :uuid do |t|
      t.jsonb :config, null: false
      t.float :durability_loss, null: false
      t.string :product_model_name, null: false
      t.string :product_model_id, null: false

      t.timestamps
    end
  end
end
