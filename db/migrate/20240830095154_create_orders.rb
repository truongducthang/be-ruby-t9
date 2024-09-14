class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :total_amount, null: false
      t.integer :total_amount_with_tax, null: false
      t.integer :status, null: false
      t.string :shipping_address
      t.string :customer_name
      t.string :stripe_checkout_session_id, index: { unique: true }
      t.string :stripe_charge_id, index: { unique: true }
      t.integer :payment_status
      t.string :error_message
      t.string :payment_url
      t.datetime :payment_date

      t.timestamps
    end
  end
end
