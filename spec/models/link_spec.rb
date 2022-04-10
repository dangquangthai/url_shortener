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
end
