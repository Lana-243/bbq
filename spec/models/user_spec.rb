require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  context 'validations check' do
    it { should validate_length_of(:name).is_at_most(25) }
  end

  describe '#set_name' do
    it 'should create name for the user' do
      expect(user.name.present?).to be true
    end
  end
end
