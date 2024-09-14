class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :description
      t.integer :price, null: false
      t.references :category, null: false, foreign_key: true
      t.integer :gender
      t.integer :recommendation_score

      t.timestamps
    end
  end
end
