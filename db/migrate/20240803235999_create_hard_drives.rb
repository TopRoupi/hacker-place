class CreateHardDrives < ActiveRecord::Migration[7.1]
  def change
    create_table :hard_drives, id: :uuid do |t|
      t.integer :capacity_megabytes, null: false
      t.integer :speed_megabytes, null: false
      t.float :durability_loss, null: false
      t.string :product_model_name, null: false
      t.string :product_model_id, null: false

      t.uuid  :socket_id, null: false
      t.string  :socket_type, null: false

      t.timestamps
    end

    add_index :hard_drives, [:socket_type, :socket_id]
  end
end
