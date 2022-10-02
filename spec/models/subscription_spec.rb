require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'validations check' do
    it { should validate_presence_of(:event) }
  end

  context 'anon user subscribes' do
    let(:subscription_anon_user) { FactoryBot.create(:subscription_anon_user) }

    it 'should be valid' do
      expect(subscription_anon_user.valid?).to be true
    end

    it 'should show user name' do
      expect(subscription_anon_user.user_name).to eq('Katie')
    end

    it 'should show email' do
      expect(subscription_anon_user.user_email).to eq('katie@gmail.com')
    end
  end

  context 'authorised user subscribes' do
    let(:subscription_auth_user) { FactoryBot.create(:subscription_auth_user) }

    it 'should be valid' do
      expect(subscription_auth_user.valid?).to be true
    end

    it 'should show user name' do
      expect(subscription_auth_user.user_name.present?).to be true
    end

    it 'should show email' do
      expect(subscription_auth_user.user_email.present?).to be true
    end
  end
end
