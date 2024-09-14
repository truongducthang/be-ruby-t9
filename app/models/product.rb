class Product < ApplicationRecord
  belongs_to :category
  has_many :product_variants, dependent: :destroy
  has_many :likes, as: :target, dependent: :destroy
  has_many :order_items, through: :product_variants
  has_many :orders, through: :order_items

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  GENDER = {
    MEN: { id: 0, jp: "メンズ" },
    LADY: { id: 1, jp: "レディース" },
    BOY: { id: 2, jp: "ボーイズ" },
    GIRL: { id: 3, jp: "ガールズ" },
    BABY: { id: 4, jp: "ベビー" }
  }.freeze

  def gender_label
    target_gender = GENDER.values.find { |g| g[:id] == gender }
    target_gender ? target_gender[:jp] : ""
  end

  def rating_info
    reviews = Review.where(product_variant_id: product_variants.pluck(:id))
    {
      average_rating: reviews.average(:rating).to_f.round(1),
      review_count: reviews.count
    }
  end

  def thumbnail_url
    product_variants.find_by(is_main_image_product: true)&.image_url ||
      product_variants.where.not(image_url: nil).first&.image_url || ""
  end

  scope :most_purchased_this_month, -> {
    select('products.id, products.name, product_variants.id as variant_id, product_variants.image_url as thumbnail_url, COALESCE(SUM(order_items.quantity), 0) as purchase_count')
      .joins(:product_variants)
      .left_joins(product_variants: { order_items: :order })
      .where(orders: { 
        created_at: Time.current.beginning_of_month..Time.current.end_of_month
      })
      .group('products.id, products.name, product_variants.id, product_variants.image_url')
      .having('COALESCE(SUM(order_items.quantity), 0) > 0')
      .order('purchase_count DESC')
  }
end
