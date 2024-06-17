class CreateVFiles < ActiveRecord::Migration[7.1]
  def change
    create_table :v_files, id: :uuid do |t|
      t.references :computer, null: false, type: :uuid
      t.string :name
      t.string :content
      t.string :type

      t.timestamps
    end

    add_index :v_files, [:name, :computer_id], unique: true
  end
end
