class Event < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :user
  has_many_attached :photos, dependent: :purge do |attachable|
    attachable.variant :thumb, resize_to_limit: [200, 200]
  end


  validates :user, presence: true
  validates :title, presence: true, length: {maximum: 255 }
  validates :address, presence: true
  validates :datetime, presence: true

  def visitors
    (subscribers + [user]).uniq
  end

  def pincode_valid?(pin2chek)
    pincode == pin2chek
  end
end
