require 'rails_helper'

RSpec.describe "API::V1::Links", type: :request do
  let(:user) { create(:user) }

  describe 'GET /api/v1/links' do
    context 'Authorized' do
      before do
        create(:link, token: 'token1', long_url: 'https://github.com', user: user)
        create(:link, token: 'token2', long_url: 'https://google.com', user: user)
        create(:link, token: 'token3', long_url: 'https://google.com')

        get api_v1_links_path, headers: { 'HTTP_API_KEY' => user.api_key }, xhr: true
      end

      it 'return data' do
        expect(response).to have_http_status(200)
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

  describe 'POST /api/v1/links' do
    context 'Authorized' do
      context 'when params is invalid' do
        before do
          expect do
            post api_v1_links_path,
              params: { link: { long_url: '' } },
              headers: { 'HTTP_API_KEY' => user.api_key },
              xhr: true
          end.not_to change { Link.count }
        end

        it 'response 422 and error messages' do
          expect(response).to have_http_status(422)
          expect(json).to eq({'errors' => {"long_url" => ["is invalid", "can't be blank"]}})
        end
      end

      context 'when params is valid' do
        before do
          expect do
            post api_v1_links_path,
              params: { link: { long_url: 'http://test.com' } },
              headers: { 'HTTP_API_KEY' => user.api_key },
              xhr: true
          end.to change { Link.count }.by(1)
        end

        it 'response 200 and created link' do
          new_link = Link.last
          expect(response).to have_http_status(200)
          expect(json).to eq({
            'short_url' => new_link.short_url,
            'long_url' => 'http://test.com',
            'clicked_count' => 0
          })
        end
      end
    end
  end
end
