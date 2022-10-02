require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'validations check' do
    it { should validate_presence_of(:event) }
    it { should validate_presence_of(:body) }
  end

  context 'anon user leaves a comment' do
    let(:comment_anon_user) { FactoryBot.create(:comment_anon_user) }

    it 'should be valid' do
      expect(comment_anon_user.valid?).to be true
    end

    it 'should show user name' do
      expect(comment_anon_user.user_name).to eq('Katie')
    end
  end

  context 'authorised user leaves a comment' do
    let(:comment_auth_user) { FactoryBot.create(:comment_auth_user) }

    it 'should be valid' do
      expect(comment_auth_user.valid?).to be true
    end

    it 'should show user name' do
      expect(comment_auth_user.user_name.present?).to be true
    end
  end
end
