class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:vkontakte, :yandex]

  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_one_attached :avatar, dependent: :purge do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
    attachable.variant :mini, resize_to_limit: [50, 50]
  end

  validates :name, presence: true, length: {maximum: 25 }

  before_validation :set_name, on: :create

  after_commit :link_subscriptions, on: :create

  def self.from_omniauth(provider_data)
    email = provider_data.info.email
    user = where(email: email).first

    return user if user.present?
    provider = provider_data.provider
    login = provider_data.extra.raw_info.id
    url = login

    where(url: url, provider: provider).first_or_create! do |user|
      user.name = provider_data.info.name
      if provider_data.info.image.nil? == false
        user.avatar.attach(io: URI.open(provider_data.info.image), filename: 'avatar.jpg')
      end
      user.email = email
      user.password = Devise.friendly_token.first(16)
    end
  end


  private

  def set_name
    self.name = "User №#{rand(777)}" if self.name.blank?
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email)
                .update_all(user_id: self.id)
  end
end
