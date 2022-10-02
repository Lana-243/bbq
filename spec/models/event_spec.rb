require 'rails_helper'

RSpec.describe Event, type: :model do
  context 'validations check' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:datetime) }

    it { should validate_length_of(:title).is_at_most(255) }
  end

  let(:event_with_pincode) { FactoryBot.create(:event, pincode: '111') }

  describe '#pincode_valid?' do
    it 'should return true if correct pincode' do
      expect(event_with_pincode.pincode_valid?('111')).to be true
    end

    it 'should return false if incorrect pincode' do
      expect(event_with_pincode.pincode_valid?('121')).to be false
    end

    it 'should return false if no pincode' do
      expect(event_with_pincode.pincode_valid?('')).to be false
    end
  end
end
