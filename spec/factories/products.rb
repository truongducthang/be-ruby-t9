require "faker"

FactoryBot.define do
  factory :product do
    association :category
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    price { Faker::Commerce.price(range: 1000..10_000) }
    gender { rand(0..2) }
    recommendation_score { rand(1..5) }
  end
end
