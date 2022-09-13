require 'rails_helper'

RSpec.describe EventPolicy do
  let(:user) { create(:user) }
  let(:user_event_owner) { create(:user) }

  let(:event) { create(:event, user: user_event_owner) }
  let(:event_with_pincode) { create(:event, user: user_event_owner, pincode: 'abc') }

  let(:event_context) { EventContext.new(event: event) }
  let(:event_context_w_correct_pincode) { EventContext.new(event: event_with_pincode, pincode: 'abc') }
  let(:event_context_w_incorrect_pincode) { EventContext.new(event: event_with_pincode, pincode: 'a') }

  subject { EventPolicy }

  context '#new?, #create?, #edit?, #update?, #destroy?' do
    context 'user is not authorized' do
      permissions :new?, :create?, :edit?, :update?, :destroy? do
        it { is_expected.not_to permit(nil, event) }
      end
    end

    context 'user is authorized' do
      context 'user is an event owner' do
        permissions :new?, :create?, :edit?, :update?, :destroy? do
          it { is_expected.to permit(user_event_owner, event) }
        end
      end

      context 'user is not an event owner' do
        permissions :edit?, :update?, :destroy? do
          it { is_expected.not_to permit(user, event) }
        end
        permissions :new?, :create? do
          it { is_expected.to permit(user, event) }
        end
      end
    end
  end

  context '#show' do
    context 'event does not have a password' do
      context 'user is not authorized' do
        permissions :show? do
          it { is_expected.to permit(nil, event_context) }
        end
      end

      context 'user is authorized' do
        permissions :show? do
          it { is_expected.to permit(user, event_context) }
        end
      end
    end

    context 'event has a password' do
      context 'user is not authorized' do
        permissions :show? do
          it { is_expected.to permit(nil, event_context_w_correct_pincode) }
        end
      end

      context 'user is authorized' do
        context 'pincode is correct' do
          permissions :show? do
            it { is_expected.to permit(user, event_context_w_correct_pincode) }
          end
        end

        context 'pincode is incorrect' do
          permissions :show? do
            it { is_expected.not_to permit(user, event_context_w_incorrect_pincode) }
          end
        end
      end
    end
  end
end
