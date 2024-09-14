class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, null: false, index: { unique: true }
      t.string :password_digest, null: false
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :last_name_furigana, null: false
      t.string :first_name_furigana, null: false
      t.string :postal_code, null: false
      t.string :prefecture, null: false
      t.string :city, null: false
      t.string :town, null: false
      t.string :chome, null: false
      t.string :banchi, null: false
      t.string :building_name, null: false
      t.string :mobile_phone
      t.integer :gender
      t.string :occupation
      t.date :birthday
      t.boolean :approved, default: false
      t.string :stripe_customer_id, index: { unique: true }

      t.timestamps
    end
  end
end
