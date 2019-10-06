class RedirectController < ApplicationController
  def show
    @shortened_url = ShortenedUrl.find_by_slug!(params[:slug])
    redirect_to @shortened_url.redirect_url
  end
end
