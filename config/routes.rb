Rails.application.routes.draw do
  root 'static_pages#home'
  get "/signup" => "users#new"
  resources :users, except: :new
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
