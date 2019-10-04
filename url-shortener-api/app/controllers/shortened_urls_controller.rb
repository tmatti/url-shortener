class ShortenedUrlsController < ApplicationController
  def create
    @url = ShortenedUrl.create(shortened_url_params)
    render json: @url
  end

  private
  def shortened_url_params
    params.require(:shortened_url).permit(:url)
  end
end
