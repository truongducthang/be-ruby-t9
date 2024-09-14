class ChangeUserTableForCustomAuth < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :encrypted_password
    remove_column :users, :jti
    add_column :users, :password_digest, :string, null: false
  end
end
