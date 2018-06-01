FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    non_gov_use_category 'Personal'
    department { Faker::Company.name }
    contactable true
  end
end
