# frozen_string_literal: true

class CreatePlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :players, id: :uuid do |t|
      t.string :email,           null: false, index: { unique: true }
      t.string :password_digest, null: false

      t.boolean :verified, null: false, default: false

      t.timestamps
    end
  end
end
