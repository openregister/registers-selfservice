FactoryBot.define do
  factory :user do
    is_government true
    email { Faker::Internet.email }
    department { Faker::Company.name }
    contactable true
  end
end
