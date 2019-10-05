Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :shortened_urls, param: :slug
  match '*unmatched_route', to: 'application#route_not_found', via: :all
end
