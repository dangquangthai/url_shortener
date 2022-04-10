require 'rails_helper'

RSpec.describe "API::V1::Links", type: :request do
  describe 'GET /api/v1/links' do
    let(:user) { create(:user) }

    context 'Authorized' do
      before do
        create(:link, token: 'token1', long_url: 'https://github.com', user: user)
        create(:link, token: 'token2', long_url: 'https://google.com', user: user)
        create(:link, token: 'token3', long_url: 'https://google.com')

        get api_v1_links_path, headers: { 'HTTP_API_KEY' => user.api_key }, xhr: true
      end

      it 'return data' do
        expect(json).to eq({
          'per_page' => 10,
          'current_page' => 1,
          'total_entries' => 2,
          'total_pages' => 1,
          'data' => [
            {
              'short_url' => 'http://localhost:3000/token1',
              'long_url' => 'https://github.com',
              'clicked_count' => 0
            },
            {
              'short_url' => 'http://localhost:3000/token2',
              'long_url' => 'https://google.com',
              'clicked_count' => 0
            }
          ]
        })
      end
    end
  end
end
