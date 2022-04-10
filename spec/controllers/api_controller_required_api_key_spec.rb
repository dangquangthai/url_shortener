require 'rails_helper'

RSpec.describe API::V1::BaseController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe '#required_current_user!' do
    controller do
      def index; end

      def create; end
    end

    context 'when api_key is not present' do
      it 'response 401' do
        get :index

        expect(response).to have_http_status(401)
        expect(response.content_type).to eq 'application/json; charset=utf-8'
        expect(json).to eq({ 'error' => 'Unauthorized' })
      end

      it 'response 401' do
        post :create

        expect(response).to have_http_status(401)
        expect(response.content_type).to eq 'application/json; charset=utf-8'
        expect(json).to eq({ 'error' => 'Unauthorized' })
      end
    end
  end
end
