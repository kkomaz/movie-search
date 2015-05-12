Rails.application.routes.draw do
  root "sessions#new"
  
  resources :users, :only => [:create] do
    resources :movies, :only => [:index, :show, :create, :destroy]
  end
  resources :sessions, :only => [:create]

  get "sign_up" => "users#new", :as => "sign_up"
  get "log_in" => "sessions#new", :as => "login"
  get 'log_out' => "sessions#destroy", :as => "logout"
  get "/:id/search" => "search#new", :as => "search"

  post '/movies' => 'movies#list'

end
