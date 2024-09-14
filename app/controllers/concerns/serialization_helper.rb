module SerializationHelper
  extend ActiveSupport::Concern

  def serialize_resource(resource, serializer: nil, **)
    ActiveModelSerializers::SerializableResource.new(resource, serializer:, **)
  end
end
