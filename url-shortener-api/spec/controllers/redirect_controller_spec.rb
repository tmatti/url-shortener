# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RedirectController, type: :controller do
  describe 'GET #show' do
    context 'with valid slug' do
      before do
        allow(SlugGenerator).to receive(:generate).and_return '00Buck'
        create(:shortened_url)
        get :show, params: { slug: '00Buck' }
      end

      it 'returns a 200' do
        expect(response.status).to eq 302
      end
    end
    context 'with invalid slug' do
      before do
        get :show, params: { slug: '00Buck' }
      end

      it 'returns a 404' do
        expect(response.status).to eq 404
      end
    end
  end
end
