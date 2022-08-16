# frozen_string_literal: true

class DeviseCreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :did, null: false, default: ""
      t.string :name
      t.string :email
      t.timestamps null: false
    end
    add_index :accounts, :did, unique: true
  end
end
