class InquirySerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :message, :status, :created_at

  def status
    object.status.to_i
  end
end
