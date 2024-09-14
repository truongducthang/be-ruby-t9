class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :gender, :recommendation_score, :image_url, :rating, :rating_record,
             :product_variants, :created_at, :updated_at

  has_many :product_variants, serializer: ProductVariantSerializer

  def gender
    object.gender_label
  end

  def rating
    object.rating_info[:average_rating]
  end

  def rating_record
    object.rating_info[:review_count]
  end

  def image_url
    object.thumbnail_url
  end
end
