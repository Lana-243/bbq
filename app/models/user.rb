class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_validation :set_name, on: :create
  has_many :events

  validates :name, presence: true, length: {maximum: 25 }

  private

  def set_name
    self.name = "User №#{rand(777)}" if self.name.blank?
  end
end
