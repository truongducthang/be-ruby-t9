class MostPurchasedProductVariantSerializer < ActiveModel::Serializer
  attributes :id, :name, :variant_id, :main_image_url, :purchase_count

  def id
    object.id
  end

  def name
    object.name
  end

  def variant_id
    object.variant_id
  end

  def main_image_url
    object.thumbnail_url
  end

  def purchase_count
    object.purchase_count.to_i
  end
end
