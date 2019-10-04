class ShortenedUrl < ApplicationRecord
  before_validation :generate_slug, on: :create
  before_validation :cleanse_url, on: :create
  validates :redirect_url, presence: true, format: { with: URI.regexp }
  validates :slug, presence: true, uniqueness: true

  private

  def cleanse_url
    unless self.redirect_url.starts_with?('http')
      self.redirect_url = "http://#{self.redirect_url}"
    end
  end

  def generate_slug
    # this gives us over 44 billion options. 62 choose 6 = n!/(n-k)! = 62!/56!
    charset = ['A'..'Z','a'..'z','0'..'9'].map{|range| range.to_a}.flatten
    self.slug = charset.sample(6).join
  end
end
