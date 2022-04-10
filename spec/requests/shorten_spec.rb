require 'rails_helper'

RSpec.describe "Shortens", type: :request do
  describe "GET /index" do
    context 'when token was given' do
      let(:link) { build_stubbed(:link, long_url: 'https://github.com', token: 'this_is_mocked_token') }

      before do
        expect(Link).to receive(:find_by!).with(token: link.token).and_return(link)
        expect(link).to receive(:clicked_count_increasing!).and_return(true)

        get shorten_path(token: link.token)
      end

      it 'called clicked_count_increasing! and redirect to long_url' do
        expect(response).to have_http_status(302)
        expect(response).to redirect_to 'https://github.com'
      end
    end
  end
end
