class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true

  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/, unless: -> { user.present? }
  validates :user_email, uniqueness: { scope: :event_id }, unless: -> { user.present? }
  validates :user, uniqueness: { scope: :event_id }, if: -> { user.present? }
  validate :event_creator_cannot_subscribe



  def user_name
    user&.name || super
  end

  def user_email
    user&.email || super
  end

  private

  def event_creator_cannot_subscribe
    if event.user == user
      errors.add(:user, message: I18n.t('shared.errors.models.subscription.event_creator_cannot_subscribe'))
    end
  end
end
