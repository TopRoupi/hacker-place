class CreateLgoProcesses < ActiveRecord::Migration[7.1]
  def change
    create_table :lgo_processes, id: :uuid do |t|
      t.references :v_process, null: false, foreign_key: true, type: :uuid, index: {unique: true}
      t.string :pid
      t.string :tcp_port
      t.string :job_id
      t.string :job_server_ip
      t.integer :state, null: false, default: 0
      t.date :started_at, null: true
      t.date :ended_at, null: true
      t.date :slept_at, null: true
      t.string :code, null: false

      t.timestamps
    end
  end
end
