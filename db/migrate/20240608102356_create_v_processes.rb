class CreateVProcesses < ActiveRecord::Migration[7.1]
  def change
    create_table :v_processes, id: :uuid do |t|
      t.references :machine, null: false, foreign_key: true, type: :uuid
      t.string :name
      t.integer :cpu_usage, null: false, default: 0
      t.integer :ram_usage, null: false, default: 0
      t.integer :state, null: false, default: 0
      t.date :started_at
      t.date :ended_at
      t.string :pid, null: false
      t.string :command, null: false

      t.timestamps
    end
  end
end
