class User < ApplicationRecord
  has_many :events

  validates :name, presence: true, length: {maximum: 25 }
  validates :email, presence: true, length: {maximum: 355 }
  validates :email, uniqueness: true
  validates :email, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/
end
