class Inquiry < ApplicationRecord
  belongs_to :user, optional: true

  validates :name, presence: true
  validates :email, presence: true
  validates :message, presence: true
end
