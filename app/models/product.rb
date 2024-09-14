class Product < ApplicationRecord
  belongs_to :category
  has_many :product_variants, dependent: :destroy
  has_many :likes, as: :target, dependent: :destroy
  has_many :order_items, through: :product_variants

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
    joins(product_variants: :order_items)
      .where(order_items: { created_at: Time.current.beginning_of_month..Time.current.end_of_month })
      .group('products.id')
      .select('products.*, COUNT(order_items.id) as purchase_count')
      .order('purchase_count DESC')
  }
end
