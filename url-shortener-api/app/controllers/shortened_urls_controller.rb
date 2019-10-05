# frozen_string_literal: true

class ShortenedUrlsController < ApplicationController
  def index
    @urls = ShortenedUrl.all
    render json: @urls
  end

  def show
    @shortened_url = ShortenedUrl.find_by_slug!(params[:slug])
    success_response(:ok, @shortened_url)
  end

  def create
    @shortened_url = ShortenedUrl.create!(shortened_url_params)
    success_response(:created, @shortened_url)
  end

  def update
    @shortened_url = ShortenedUrl.find_by_slug!(params[:slug])
    @shortened_url.redirect_url = params[:redirect_url]
    @shortened_url.save!
    success_response(:ok, @shortened_url)
  end

  private

  def shortened_url_params
    params.require(:shortened_url).permit(:redirect_url)
  end
end
