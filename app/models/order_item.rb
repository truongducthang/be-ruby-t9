class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product_variant
  has_one :product, through: :product_variant

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :unshipped_with_details, -> {
    joins(product_variant: :product)
      .joins(:order)
      .where(orders: { status: Order::STATUS[:UNSHIPPED] })
      .select('order_items.id AS order_item_id,
               products.id AS product_id, 
               products.name AS product_name, 
               product_variants.id AS variant_id, 
               product_variants.image_url AS thumbnail_url, 
               order_items.price, 
               order_items.quantity,
               orders.created_at AS purchase_date')
      .order('orders.created_at DESC')
  }
end
