class UserSerializer < ActiveModel::Serializer
  attributes :email, :service, :department, :api_key, :is_government
end
