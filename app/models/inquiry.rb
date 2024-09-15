class Inquiry < ApplicationRecord
  belongs_to :user, optional: true

  validates :name, presence: true
  validates :email, presence: true
  validates :message, presence: true

  STATUS = { PENDING: 0, RESOLVED: 1 }.freeze
end
