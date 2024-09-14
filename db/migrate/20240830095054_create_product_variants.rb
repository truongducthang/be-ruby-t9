class CreateProductVariants < ActiveRecord::Migration[7.1]
  def change
    create_table :product_variants do |t|
      t.references :product, null: false, foreign_key: true
      t.references :size, null: false, foreign_key: true
      t.references :color, null: false, foreign_key: true
      t.string :sku, null: false, index: { unique: true }
      t.integer :stock_quantity
      t.string :image_url
      t.boolean :is_main_image_product, default: false

      t.timestamps
    end
  end
end
