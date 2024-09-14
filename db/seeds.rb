# rubocop:disable Lint/UselessAssignment

require "faker"
# Define record number
USER_RECORD_NUMBER = 5
CATEGORY_RECORD_NUMBER = 3
SUBCATEGORY_RECORD_NUMBER = 3
PRODUCT_RECORD_NUMBER = 30

# Clear existing data
AdminUser.destroy_all
User.destroy_all
Category.destroy_all
Product.destroy_all
Size.destroy_all
Color.destroy_all
ProductVariant.destroy_all
CartItem.destroy_all
Order.destroy_all
OrderItem.destroy_all
Like.destroy_all
Review.destroy_all
Inquiry.destroy_all

# Seed Admins
AdminUser.create!(
  email: "admin@example.com",
  password: "password",
  name: "Admin User"
)

# Seed Users
users = USER_RECORD_NUMBER.times.map do
  User.create!(
    email: Faker::Internet.unique.email,
    password: "password",
    last_name: Faker::Name.last_name,
    first_name: Faker::Name.first_name,
    last_name_furigana: Faker::JapaneseMedia::DragonBall.character,
    first_name_furigana: Faker::JapaneseMedia::DragonBall.character,
    postal_code: Faker::Address.zip_code,
    prefecture: Faker::Address.state,
    city: Faker::Address.city,
    town: Faker::Address.street_name,
    chome: Faker::Address.secondary_address,
    banchi: Faker::Address.building_number,
    building_name: Faker::Address.community,
    mobile_phone: Faker::PhoneNumber.cell_phone,
    gender: User::GENDER.values.sample,
    occupation: Faker::Job.title,
    birthday: Faker::Date.birthday(min_age: 18, max_age: 65),
    approved: true,
    stripe_customer_id: Faker::Alphanumeric.unique.alphanumeric(number: 10)
  )
end

category_data = {
  "トップス" => ["Tシャツ・スウェット"],
  "パンツ" => ["チノパンツ・ジーンズ"],
  "シューズ" => %w[スニーカー サンダル]
}

# Seed Categories and Subcategories
categories = category_data.map do |category_name, subcategory_names|
  parent_category = Category.create!(
    name: category_name,
    image_url: Faker::LoremFlickr.image(size: "80x80", search_terms: ["category"]),
    parent: nil
  )

  subcategories = subcategory_names.map do |subcategory_name|
    Category.create!(
      name: subcategory_name,
      image_url: Faker::LoremFlickr.image(size: "80x80", search_terms: ["category"]),
      parent: parent_category
    )
  end

  { parent: parent_category, subcategories: }
end

# Seed Products
products = PRODUCT_RECORD_NUMBER.times.map do
  Product.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.sentence,
    price: Faker::Commerce.price(range: 1000..10_000),
    category: categories.sample[:subcategories].sample,
    gender: Product::GENDER.values.sample[:id],
    recommendation_score: rand(1..5)
  )
end

# Seed Sizes
sizes = %w[XS S M L XL XXL].map do |size|
  Size.create!(size:)
end

# Seed Colors
colors = %w[レッド ブルー ブラウン パープル イエロー ベージュ グリーン ブラック オレンジ ホワイト].map do |color|
  Color.create!(color:)
end

# Seed Product Variants

product_variants = products.flat_map do |product|
  3.times.map do
    ProductVariant.create!(
      product_id: product.id,
      size: sizes.sample,
      color: colors.sample,
      sku: Faker::Alphanumeric.unique.alphanumeric(number: 10).upcase,
      stock_quantity: rand(10..100),
      image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ["product"]),
      is_main_image_product: [true, false].sample
    )
  end
end

# Seed Cart Items
cart_items = users.flat_map do |user|
  2.times.map do
    CartItem.create!(
      user:,
      product_variant: product_variants.sample,
      quantity: rand(1..5)
    )
  end
end

# Seed Orders
# orders = users.flat_map do |user|
#   2.times.map do
#     Order.create!(
#       user:,
#       total_amount: Faker::Commerce.price(range: 5000..50_000),
#       total_amount_with_tax: Faker::Commerce.price(range: 5000..50_000),
#       status: Order::STATUS.values.sample,
#       shipping_address: Faker::Address.full_address,
#       customer_name: "#{user.last_name} #{user.first_name}",
#       stripe_checkout_session_id: Faker::Alphanumeric.unique.alphanumeric(number: 10),
#       stripe_charge_id: Faker::Alphanumeric.unique.alphanumeric(number: 10),
#       payment_status: Order::PAYMENT_STATUS.values.sample,
#       error_message: [nil, "Payment failed"].sample,
#       payment_url: Faker::Internet.url,
#       payment_date: [Faker::Date.backward(days: 14), nil].sample
#     )
#   end
# end

# # Seed Order Items
# orders.each do |order|
#   3.times do
#     OrderItem.create!(
#       order:,
#       product_variant: product_variants.sample,
#       quantity: rand(1..3),
#       price: Faker::Commerce.price(range: 1000..10_000)
#     )
#   end
# end

# # Seed Likes
# likes = users.flat_map do |user|
#   3.times.map do
#     Like.create!(
#       user:,
#       target: [products.sample, categories.sample[:subcategories].sample].sample
#     )
#   end
# end

# # Seed Reviews
# reviews = users.flat_map do |user|
#   2.times.map do
#     Review.create!(
#       user:,
#       product_variant: product_variants.sample,
#       rating: rand(1..5),
#       comment: Faker::Lorem.sentence
#     )
#   end
# end

# # Seed Inquiries
# inquiries = users.flat_map do |user|
#   2.times.map do
#     Inquiry.create!(
#       user:,
#       name: "#{user.last_name} #{user.first_name}",
#       email: user.email,
#       message: Faker::Lorem.paragraph,
#       status: %w[pending resolved].sample
#     )
#   end
# end

puts "Seed data has been created successfully!"

# rubocop:enable Lint/UselessAssignment
