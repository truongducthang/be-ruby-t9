FactoryBot.define do
  factory :review do
    association :user
    association :product_variant
    rating { rand(1..5) }
    comment { "sample-comment" }
  end
end
