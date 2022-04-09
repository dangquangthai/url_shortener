require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.association' do
    it { is_expected.to have_many(:links).dependent(:destroy) }
  end

  describe '.validation' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:name) }

    describe 'unique #email' do
      subject { build(:user, email: 'test@test.com') }

      before { create(:user, email: 'test@test.com') }

      it { expect(subject).to validate_uniqueness_of(:email).case_insensitive }
    end
  end
end
