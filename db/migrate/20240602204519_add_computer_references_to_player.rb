class AddComputerReferencesToPlayer < ActiveRecord::Migration[7.1]
  def change
    add_reference :players, :computer, index: true, null: true, type: :uuid
  end
end
