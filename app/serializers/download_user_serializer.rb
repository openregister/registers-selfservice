class DownloadUserSerializer < ActiveModel::Serializer
  attributes :email, :non_gov_use_category, :department, :is_government, :register
end
