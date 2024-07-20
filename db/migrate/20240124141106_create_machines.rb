class CreateMachines < ActiveRecord::Migration[7.1]
  def change
    create_table :machines, id: :uuid do |t|
      t.timestamps
    end
  end
end
