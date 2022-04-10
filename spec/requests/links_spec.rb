require 'rails_helper'

RSpec.describe "Links", type: :request do
  let(:user) { build_stubbed(:user) }

  describe "GET /index" do
    include_examples 'Required user login', :get, '/links'

    context 'when user logged-in' do
      before { sign_in user }

      it 'response 200 and render view' do
        get '/links'

        expect(response).to have_http_status(200)
        expect(response).to render_template('links/index')
        expect(assigns(:links)).to be_a ActiveRecord::AssociationRelation
      end
    end
  end

  describe "GET /new" do
    include_examples 'Required user login', :get, '/links/new'

    context 'when user logged-in' do
      before { sign_in user }

      it 'response 200 and render view' do
        get new_link_path

        expect(response).to have_http_status(200)
        expect(response).to render_template('links/new')
      end
    end
  end

  describe "POST /create" do
    include_examples 'Required user login', :post, '/links'

    context 'when user logged-in' do
      before { sign_in user }

      context 'when params is not given' do
        it 'response 400' do
          post links_path

          expect(response).to have_http_status(400)
          expect(response.content_type).to eq 'application/json; charset=utf-8'
          expect(json).to eq({ 'error' => 'Required params is missing' })
        end
      end

      context 'when params is given' do
        context 'when params is valid' do
          before do
            expect {
              post links_path, params: { link: { long_url: 'https://google.com.vn' } }
            }.to change { Link.count }.by(1)
          end

          it 'creates a link and redirect to /links' do
            expect(response).to have_http_status(302)
            expect(response).to redirect_to '/links'
            expect(flash[:notice]).to eq 'Link was successfully created'
          end
        end

        context 'when params is invalid' do
          before do
            expect {
              post links_path, params: { link: { long_url: '' } }
            }.not_to change { Link.count }
          end

          it 'response 422 and error messages' do
            expect(response).to have_http_status(422)
            expect(response).to render_template('links/new')
            expect(assigns(:new_link)).to be_a Link
            expect(flash[:error]).to eq 'Something went wrong, please review below errors'
          end
        end
      end
    end
  end

  describe "GET /edit" do
    include_examples 'Required user login', :get, '/links/1/edit'

    context 'when user logged-in' do
      let(:link) { build_stubbed(:link) }

      before do
        sign_in user
        expect(user).to receive_message_chain(:links, :find).with(link.id.to_s).and_return(link)
      end

      it 'response 200 and render view' do
        get edit_link_path(link)

        expect(response).to have_http_status(200)
        expect(response).to render_template('links/edit')
      end
    end
  end

  describe 'PATCH /update' do
    include_examples 'Required user login', :patch, '/links/1'

    context 'when user logged-in' do
      let!(:link) { create(:link, user: user, long_url: 'http://localhost') }

      before { sign_in user }

      context 'when params is valid' do
        before do
          expect(link.long_url).to eq 'http://localhost'

          patch link_path(link), params: { link: { long_url: 'https://google.com.vn' }, id: link.id }
        end

        it 'updates link and redirect to /links' do
          expect(link.reload.long_url).to eq 'https://google.com.vn'

          expect(response).to have_http_status(302)
          expect(response).to redirect_to '/links'
          expect(flash[:notice]).to eq 'Link was successfully updated'
        end
      end

      context 'when params is invalid' do
        before do
          expect(link.long_url).to eq 'http://localhost'

          patch link_path(link), params: { link: { long_url: '' }, id: link.id }
        end

        it "dosen't update and response 422" do
          expect(link.reload.long_url).to eq 'http://localhost'

          expect(response).to have_http_status(422)
          expect(response).to render_template('links/edit')
          expect(assigns(:link)).to be_a Link
          expect(flash[:error]).to eq 'Something went wrong, please review below errors'
        end
      end
    end
  end
end
