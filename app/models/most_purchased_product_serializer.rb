class MostPurchasedProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :main_image_url, :purchase_count

  def main_image_url
    object.thumbnail_url
  end

  def purchase_count
    object.purchase_count.to_i
  end
end
