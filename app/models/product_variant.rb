class ProductVariant < ApplicationRecord
  belongs_to :product
  belongs_to :size
  belongs_to :color
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :sku, presence: true, uniqueness: true
  validates :stock_quantity, numericality: { greater_than_or_equal_to: 0 }
end
