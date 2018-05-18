Rails.application.routes.draw do
  root 'static_pages#home'
  get '/signup'    => 'users#new'
  get '/login'     => 'sessions#new'
  post '/login'    => 'sessions#create'
  delete '/logout' => 'sessions#destroy' 

  resources :categories
  resources :lessons do
    resources :lesson_words, path: "words", as: "words" #pathで指定した名前をlesson_wordsの代わりに利用できる #
  end
  resources :relationships, only: [:create, :destroy]
  resources :users, except: :new do
    member do  #memberメソッドを使うとユーザーidがURLに含まれるように扱う
      get :following, :followers #/users/:id/followers(.:format)
    end
    resources :words, only: [:index]
  end

end


