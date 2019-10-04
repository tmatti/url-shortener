class ShortenedUrlsController < ApplicationController
  def index
    @urls = ShortenedUrl.all
    render json: @urls
  end

  def show
    @shortened_url = ShortenedUrl.find_by_slug(params[:slug])
    render json: @shortened_url
  end

  def create
    @shortened_url = ShortenedUrl.create!(shortened_url_params)
    render json: @shortened_url
  end

  private
  def shortened_url_params
    params.require(:shortened_url).permit(:redirect_url)
  end
end
