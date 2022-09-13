class EventPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def new?
    create?
  end

  def show?
    password_valid?(record)
  end

  def edit?
    update?
  end

  def update?
    user_is_owner?(record)
  end

  def destroy?
    update?
  end

  private

  def user_is_owner?(event)
    user.present? && (event.try(:user) == user)
  end

  def password_valid?(event_context)
    return true if event_context.event.pincode.blank?
    return true if user.present? && user == event_context.event.user

    event_context.pincode.present? && event_context.event.pincode_valid?(event_context.pincode)
  end
end
