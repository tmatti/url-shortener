require 'slug_generator'

class ShortenedUrl < ApplicationRecord
  before_validation :generate_slug, on: :create
  before_validation :cleanse_url, on: [:create, :update], if: 'redirect_url.present?'
  validates :redirect_url, presence: true, format: {with: URI::DEFAULT_PARSER.regexp[:ABS_URI]}
  validates :slug, presence: true, uniqueness: true

  private

  def cleanse_url
    unless self.redirect_url.starts_with?('http')
      self.redirect_url = "http://#{self.redirect_url}"
    end
  end

  def generate_slug
    if self.slug.blank?
      self.slug = SlugGenerator.generate
    end
  end
end
