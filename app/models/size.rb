class Size < ApplicationRecord
  has_many :product_variants, dependent: :destroy

  validates :size, presence: true
end
