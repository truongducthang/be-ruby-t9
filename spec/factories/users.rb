require "faker"

FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { "password" }
    last_name { Faker::Name.last_name }
    first_name { Faker::Name.first_name }
    last_name_furigana { Faker::JapaneseMedia::DragonBall.character }
    first_name_furigana { Faker::JapaneseMedia::DragonBall.character }
    postal_code { Faker::Address.zip_code }
    prefecture { Faker::Address.state }
    city { Faker::Address.city }
    town { Faker::Address.street_name }
    chome { Faker::Address.secondary_address }
    banchi { Faker::Address.building_number }
    building_name { Faker::Address.community }
    mobile_phone { Faker::PhoneNumber.cell_phone }
    gender { rand(0..2) }
    occupation { Faker::Job.title }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
    approved { true }
  end
end
