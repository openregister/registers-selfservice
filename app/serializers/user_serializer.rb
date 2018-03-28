class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :service, :department, :api_key
end
