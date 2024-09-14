class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :email,
             :last_name,
             :first_name,
             :last_name_furigana,
             :first_name_furigana,
             :postal_code, :prefecture,
             :city,
             :town,
             :chome,
             :banchi,
             :building_name,
             :mobile_phone, :gender,
             :occupation,
             :birthday,
             :approved,
             :stripe_customer_id,
             :created_at,
             :updated_at

  def attributes(*args)
    data = super
    data.slice!(:id, :email) if instance_options[:auth_info]
    data
  end
end
