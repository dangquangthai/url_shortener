RSpec.shared_examples 'Required user login' do |http_method, access_path|
  context 'when user not logged-in yet' do
    it 'response 302 and redirect to /users/sign_in' do
      send http_method, access_path

      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end
  end
end
