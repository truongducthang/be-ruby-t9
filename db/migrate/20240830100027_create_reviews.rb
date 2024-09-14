class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product_variant, null: false, foreign_key: true
      t.integer :rating, null: false
      t.string :comment

      t.timestamps
    end
  end
end
