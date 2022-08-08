class Photo < ApplicationRecord
  belongs_to :event
  belongs_to :user

  has_one_attached :attached_photo, dependent: :purge do |attachable|
    attachable.variant :thumb, resize_to_limit: [200, 200]
  end

  validates :event, presence: true
  validates :user, presence: true
  validates :attached_photo, presence: true

  scope :persisted, -> { where.not(id: nil)}
end
