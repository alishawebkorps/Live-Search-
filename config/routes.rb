Rails.application.routes.draw do
 
  resources :users
  root to: "users#index"
  get '/search', to:'users#search' 
end
