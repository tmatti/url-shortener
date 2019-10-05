# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShortenedUrlsController, type: :controller do
  let :slug_regex do
    /^[A-Za-z0-9]{6,}$/
  end

  describe 'POST #create' do
    context 'with correct params' do
      before do
        post :create, params: { shortened_url: { redirect_url: 'http://stord.com' } }
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
    context 'with invalid redirect_url' do
      before do
        post :create, params: { shortened_url: { redirect_url: '#$^@#%$%%^$%@' } }
      end

      it 'returns a 400' do
        expect(response.status).to eq 400
      end

      it 'returns an error message' do
        expect(JSON.parse(response.body)['message']).to eq 'Validation failed: Redirect url is invalid'
      end
    end
    context 'with no redirect_url' do
      before do
        post :create, params: { shortened_url: { redirect_url: '' } }
      end

      it 'returns a 400' do
        expect(response.status).to eq 400
      end

      it 'returns an error message' do
        expect(JSON.parse(response.body)['message']).to eq "Validation failed: Redirect url can't be blank, Redirect url is invalid"
      end
    end
    context 'with a slug' do
      before do
        post :create, params: { shortened_url: { redirect_url: 'https://stord.com/warehouse/1', slug: '00Buck' } }
      end

      it 'returns a 201' do
        expect(response.status).to eq 201
      end

      it 'ignores the slug and creates its own' do
        expect(JSON.parse(response.body)['slug']).to_not eq '00Buck'
      end
    end
    context 'when an error occurs' do
      before do
        allow(ShortenedUrl).to receive(:create!).and_raise StandardError
        post :create, params: { shortened_url: { redirect_url: 'https://stord.com/' } }
      end

      it 'returns a 500' do
        expect(response.status).to eq 500
      end

      it 'returns the correct message' do
        expect(JSON.parse(response.body)['message']).to eq 'StandardError'
      end
    end
  end

  describe 'GET #show' do
    context 'with valid slug' do
      before do
        allow(SlugGenerator).to receive(:generate).and_return '00Buck'
        create(:shortened_url)
        get :show, params: { slug: '00Buck' }
      end

      it 'returns a 200' do
        expect(response.status).to eq 200
      end

      it 'returns the slug' do
        expect(JSON.parse(response.body)['slug']).to eq '00Buck'
      end

      it 'returns the redirect_url' do
        expect(JSON.parse(response.body)['redirect_url']).to match URI::DEFAULT_PARSER.make_regexp
      end
    end
    context 'with a nonexistant slug' do
      before do
        get :show, params: { slug: 'N0SLUG' }
      end

      it 'returns a 404' do
        expect(response.status).to eq 404
      end

      it 'returns the correct message' do
        expect(JSON.parse(response.body)['message']).to eq 'Not found'
      end
    end
    context 'when an error occurs' do
      before do
        allow(ShortenedUrl).to receive(:find_by_slug!).and_raise StandardError
        get :show, params: { slug: 'N0SLUG' }
      end

      it 'returns a 500' do
        expect(response.status).to eq 500
      end

      it 'returns the correct message' do
        expect(JSON.parse(response.body)['message']).to eq 'StandardError'
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid redirect_url' do
      before do
        allow(SlugGenerator).to receive(:generate).and_return '00Buck'
        create(:shortened_url)
        put :update, params: { slug: '00Buck', redirect_url: 'https://stord.com' }
      end

      it 'returns a 200' do
        expect(response.status).to eq(200)
      end

      it 'returns updates the redirect_url' do
        expect(JSON.parse(response.body)['redirect_url']).to eq 'https://stord.com'
      end
    end
    context 'with invalid redirect_url' do
      before do
        allow(SlugGenerator).to receive(:generate).and_return '00Buck'
        create(:shortened_url)
        put :update, params: { slug: '00Buck', redirect_url: '$$$#^%#$%#$' }
      end

      it 'returns a 200' do
        expect(response.status).to eq(400)
      end

      it 'returns updates the redirect_url' do
        expect(JSON.parse(response.body)['message']).to eq 'Validation failed: Redirect url is invalid'
      end
    end
    context 'with no redirect_url' do
      before do
        allow(SlugGenerator).to receive(:generate).and_return '00Buck'
        create(:shortened_url)
        put :update, params: { slug: '00Buck' }
      end

      it 'returns a 400' do
        expect(response.status).to eq(400)
      end

      it 'returns an error message' do
        expect(JSON.parse(response.body)['message']).to eq "Validation failed: Redirect url can't be blank, Redirect url is invalid"
      end
    end
  end
end
