require 'rails_helper'

RSpec.describe ShortenedUrlsController, type: :controller do
  let :slug_regex do
    /^[A-Za-z0-9]{6,}$/
  end

  describe 'POST #create' do
    context 'with correct params' do
      before do
        post :create, params: {shortened_url: {redirect_url: 'http://stord.com'}}
      end

      it 'returns a 201' do
        expect(response.status).to eq 201
      end

      it 'returns a redirect url' do
        expect(JSON.parse(response.body)['redirect_url']).to eq 'http://stord.com'
      end

      it 'returns a slug' do
        expect(JSON.parse(response.body)['slug']).to match slug_regex
      end
    end
  end

  describe 'GET #show' do
    context 'with valid slug' do
      before do
        allow ShortenedUrl.to receive(:generate_slug).and_return
        post :create, params: {redirect_url: 'stord.com'}
        get :show, params: {slug: '00Buck'}
      end

      it 'returns a 200' do
        expect(response.status).to eq 200
      end
    end
  end

  describe 'PUT #update' do
    context 'with no params' do
      before do
        put :update
      end

      it 'returns a 400' do
        expect(response.status).to eq(400)
      end

      it 'returns an error message' do
        expect(response.body).to match(/Validation failed: Redirect url can't be blank, Redirect url is invalid/)
      end
    end
  end
end
