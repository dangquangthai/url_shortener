require 'rails_helper'

RSpec.describe "Links", type: :request do
  let(:user) { build_stubbed(:user) }

  describe "GET /index" do
    context 'when user not logged-in yet' do
      it 'response 302 and redirect to /users/sign_in' do
        get links_path

        expect(response).to have_http_status(302)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when user logged-in' do
      before { sign_in user }

      it 'response 200 and render view' do
        get links_path

        expect(response).to have_http_status(200)
        expect(response).to render_template('links/index')
      end
    end
  end
end
