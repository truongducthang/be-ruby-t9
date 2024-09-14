FactoryBot.define do
  factory :color do
    color { %w[Red Green Blue White Black].sample }
  end
end
