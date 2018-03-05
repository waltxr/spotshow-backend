Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get 'login', to: 'logins#create'
      post 'dashboard', to: 'users#create'
      post 'events', to: 'users#show'
      post 'favorite_venues', to: 'user_venues#create'
      post 'get_favorite_venues', to: 'user_venues#show'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
