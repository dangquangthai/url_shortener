require 'rails_helper'

RSpec.describe "[Devise] Customization - Users::Registrations", type: :request do
  describe 'POST /create' do
    context 'when params is valid' do
      it 'creates a user and redirect to /users/sign_in' do
        expect do
          post user_registration_path, params: {
            user: {
              name: 'Thai Dang',
              email: 'thai.hulk@gmail.com',
              password: '123456',
              password_confirmation: '123456'
            }
          }
        end.to change { User.count }.by(1)
        
        new_user = User.last
        expect(new_user.name).to eq 'Thai Dang'
        expect(new_user.email).to eq 'thai.hulk@gmail.com'

        expect(response).to have_http_status(302)
        expect(response).to redirect_to root_path
      end
    end
  end
end
