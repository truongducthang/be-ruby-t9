class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :total_amount_with_tax, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :shipping_address, presence: true
  validates :customer_name, presence: true

  STATUS = { UNSHIPPED: 0, SHIPPED: 1, DELIVERED: 2, PURCHASE_CANCELED: 3, PAYMENT_FAILED: 4 }.freeze
  PAYMENT_STATUS = { PENDING: 0, SUCCESS: 1, FAILURED: 2, EXPIRED: 3, CANCELED: 4 }.freeze
end
