Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  root "home#index"

  resources :games, param: :game_code, only: [ :create, :show, :destroy ] do
    post :start, on: :member
    post :vote, on: :member
    delete :leave, on: :member
    get :player_data, on: :member
    post :join, on: :collection
  end
end
