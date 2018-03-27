FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    service { Faker::Company.name }
    department { Faker::Company.name }
  end
end