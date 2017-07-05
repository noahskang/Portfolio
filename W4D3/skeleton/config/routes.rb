NinetyNineCatsDay1::Application.routes.draw do
  resources :cats, except: :destroy
  resources :cat_rental_requests, only: [:create, :new] do
    post "approve", on: :member
    post "deny"
  end

  resources :users, only: [:create, :new]
  resource :sessions, only: [:create, :new, :destroy]

  root to: redirect("/cats")
end
