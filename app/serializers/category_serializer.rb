class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :image_url, :parent_id, :created_at, :updated_at
end
