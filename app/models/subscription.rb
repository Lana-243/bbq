class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true

  with_options if: -> { user.present? } do
    validates :user, uniqueness: { scope: :event_id }
    validate :event_creator_cannot_subscribe
  end

  with_options unless: -> { user.present? } do
    validates :user_name, presence: true
    validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/
    validates :user_email, uniqueness: { scope: :event_id }
    validate :user_is_signed_up
  end

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

  def user_is_signed_up
    if User.where(email: user_email).present?
      errors.add(:user_email, message: I18n.t('shared.errors.models.subscription.user_signed_up'))
    end
  end
end
