Rails.application.routes.draw do
  resources :rooms
  
  resource :session, only: %i(new) 
  get "/auth/google_oauth2/callback", to: "sessions#create"  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
