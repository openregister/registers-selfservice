class UserSerializer < ActiveModel::Serializer
  attributes :email, :non_gov_use_category, :department, :api_key, :is_government
end
