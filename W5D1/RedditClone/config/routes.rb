Rails.application.routes.draw do
  resources :subs do
    resources :posts, only: [:new, :create]
  end
  resources :posts, except: [:new, :create]
  resources :users
  resource :session
end
