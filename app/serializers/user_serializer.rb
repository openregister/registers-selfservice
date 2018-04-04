class UserSerializer < ActiveModel::Serializer
  attributes :email, :service, :department, :api_key
end
