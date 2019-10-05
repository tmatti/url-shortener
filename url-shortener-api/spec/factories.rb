require 'faker'
require 'slug_generator'

FactoryBot.define do
  factory :shortened_url do
    redirect_url { Faker::Internet.url }
    slug { SlugGenerator.generate }
  end
end