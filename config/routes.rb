Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  root "home#index"

  resources :games, only: [ :create, :show ] do
    post :start, on: :member
    post :vote, on: :member
    post :join, on: :collection
  end
end
