require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { build_stubbed(:user) }

  before do
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe '#not_found' do
    controller do
      def show
        Link.find(params[:id])
      end
    end

    it 'response 404' do
      get :show, params: { id: 1 }

      expect(response).to have_http_status(404)
      expect(response.content_type).to eq 'application/json; charset=utf-8'
      expect(json).to eq({ 'error' => 'Resource not found' })
    end
  end

  describe '#bad_request' do
    controller do
      def create
        Link.create(params.require(:link))
      end
    end

    it 'response 400' do
      post :create

      expect(response).to have_http_status(400)
      expect(response.content_type).to eq 'application/json; charset=utf-8'
      expect(json).to eq({ 'error' => 'Required params is missing' })
    end
  end

  describe '#internal_server_error' do
    controller do
      def index
        raise StandardError, 'Catcha!!!'
      end
    end

    it 'response 500' do
      get :index

      expect(response).to have_http_status(500)
      expect(response.content_type).to eq 'application/json; charset=utf-8'
      expect(json).to eq({ 'error' => 'Catcha!!!' })
    end
  end

  describe '#unauthorized' do
    controller do
      def index
        raise HasRescue::Unauthorized
      end
    end

    it 'response 401' do
      get :index

      expect(response).to have_http_status(401)
      expect(response.content_type).to eq 'application/json; charset=utf-8'
      expect(json).to eq({ 'error' => 'Unauthorized' })
    end
  end
end
