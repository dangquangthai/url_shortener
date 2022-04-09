require 'rails_helper'

RSpec.describe Link, type: :model do
  describe '.association' do
    it { is_expected.to belong_to(:user) }
  end

  describe '.validation' do
    it { is_expected.to validate_presence_of(:long_url) }
  end
end
