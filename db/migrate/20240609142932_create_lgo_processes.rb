class CreateLgoProcesses < ActiveRecord::Migration[7.1]
  def change
    create_table :lgo_processes, id: :uuid do |t|
      t.references :v_process, null: false, foreign_key: true, type: :uuid
      t.string :pid, null: false
      t.string :tcp_port
      t.string :job_id
      t.string :job_server_ip
      t.integer :state, null: false, default: 0

      t.timestamps
    end
  end
end
