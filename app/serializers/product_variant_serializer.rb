class ProductVariantSerializer < ActiveModel::Serializer
  attributes :id, :size, :color, :sku, :stock_quantity, :image_url, :is_main_image_product, :created_at, :updated_at

  belongs_to :size, serializer: SizeSerializer
  belongs_to :color, serializer: ColorSerializer
end
