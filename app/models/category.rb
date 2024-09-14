class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  belongs_to :parent, class_name: "Category", optional: true
  has_many :subcategories, class_name: "Category", foreign_key: "parent_id", dependent: :destroy
  has_many :likes, as: :target, dependent: :destroy

  validates :name, presence: true

  scope :subcategories, lambda {
    joins(:parent).where.not(parent_id: nil).where(parents_categories: { parent_id: nil })
  }
end
