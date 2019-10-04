require 'rails_helper'

RSpec.describe ShortenedUrl, type: :model do
  let :slug_regex do
    /^[A-Za-z0-9]{6,}$/
  end

  context 'with valid redirect_url' do
    let :subject do
      ShortenedUrl.create!(redirect_url: 'http://stord.com')
    end

    it 'is valid' do
      expect(subject).to be_valid
    end

    it 'generates a slug' do
      expect(subject.slug).to match slug_regex
    end
  end

  context 'with just a domain' do
    let :subject do
      ShortenedUrl.create!(redirect_url: 'stord.com')
    end

    it 'defaults to http' do
      expect(subject.redirect_url).to eq 'http://stord.com'
    end
  end

  context 'with subdomain and no protocol' do
    let :subject do
      ShortenedUrl.create!(redirect_url: 'www.stord.com')
    end

    it 'defaults to http and keeps subdomain' do
      expect(subject.redirect_url).to eq 'http://www.stord.com'
    end
  end

  context 'with https' do
    let :subject do
      ShortenedUrl.create!(redirect_url: 'https://www.stord.com')
    end

    it 'maintains https' do
      expect(subject.redirect_url).to eq 'https://www.stord.com'
    end
  end

  context 'with path and parameters' do
    let :subject do
      ShortenedUrl.create!(redirect_url: 'stord.com/shippers?industry=retail&size=enterprise')
    end

    it 'keeps path and params' do
      expect(subject.redirect_url).to eq 'http://stord.com/shippers?industry=retail&size=enterprise'
    end
  end
end
