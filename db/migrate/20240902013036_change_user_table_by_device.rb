class ChangeUserTableByDevice < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :password_digest
    change_table :users, bulk: true do |t|
      ## Database authenticatable
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token, index: { unique: true }
      t.datetime :reset_password_sent_at
      t.string :jti, null: false, index: { unique: true }

      ## Rememberable
      t.datetime :remember_created_at
    end
  end
end
