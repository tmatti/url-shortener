# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :shortened_urls, param: :slug
  get '/:slug', to: 'redirect#show'
  match '*unmatched_route', to: 'application#route_not_found', via: :all
end
