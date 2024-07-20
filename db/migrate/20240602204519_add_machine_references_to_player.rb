class AddMachineReferencesToPlayer < ActiveRecord::Migration[7.1]
  def change
    add_reference :players, :machine, index: true, null: true, type: :uuid
  end
end
