class UnshippedProductSerializer < ActiveModel::Serializer
  attributes :order_item_id, :product_id, :product_name, :variant_id, :thumbnail_url, :price, :quantity, :purchase_date

  def order_item_id
    object.order_item_id.to_i
  end

  def product_id
    object.product_id.to_i
  end

  def variant_id
    object.variant_id.to_i
  end

  def price
    object.price.to_f
  end

  def quantity
    object.quantity.to_i
  end

  def purchase_date
    object.purchase_date.strftime('%Y-%m-%d %H:%M:%S')
  end
end
