require "faker"

FactoryBot.define do
  factory :product_variant do
    association :product
    association :size
    association :color
    sku { Faker::Alphanumeric.unique.alphanumeric(number: 10).upcase }
    stock_quantity { rand(10..100) }
    image_url { Faker::LoremFlickr.image(size: "300x300", search_terms: ["product"]) }
    is_main_image_product { [true, false].sample }
  end
end
