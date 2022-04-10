require 'rails_helper'

RSpec.describe Link, type: :model do
  describe '.association' do
    it { is_expected.to belong_to(:user) }
  end

  describe '.validation' do
    it { is_expected.to validate_presence_of(:long_url) }
  end

  describe '.scopes' do
    describe '.sorted_by_created_at' do
      it 'generate sql statement' do
        sql = described_class.sorted_by_created_at.to_sql

        expect(sql).to include("ORDER BY \"links\".\"created_at\" ASC")
      end
    end
  end

  describe '#clicked_count_increasing!' do
    subject { create(:link) }

    before { expect(subject.clicked_count).to eq 0 }

    it 'increases clicked_count to 1' do
      subject.clicked_count_increasing!
      expect(subject.reload.clicked_count).to eq 1
    end
  end

  describe '#short_url' do
    subject { build_stubbed(:link, token: 'this_is_mocked_token') }

    it 'return shorten url' do
      expect(subject.short_url).to eq 'http://localhost:3000/this_is_mocked_token'
    end
  end
end
