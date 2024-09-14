FactoryBot.define do
  factory :size do
    size { %w[S M L XL XXL].sample }
  end
end
