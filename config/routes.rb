Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get 'login', to: 'logins#create'
      post 'dashboard', to: 'users#create'
      get 'events', to: 'users#show'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
