class AddMachineReferencesToPlayer < ActiveRecord::Migration[7.1]
  def change
    add_reference :players, :machine, foreign_key: true, index: true, null: true, type: :uuid
  end
end
