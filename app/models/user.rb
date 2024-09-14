class User < ApplicationRecord
  has_secure_password

  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :inquiries, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  GENDER = { MALE: 0, FEMALE: 1, OTHER: 2 }.freeze
end
