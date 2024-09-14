class Color < ApplicationRecord
  has_many :product_variants, dependent: :destroy

  validates :color, presence: true
end
