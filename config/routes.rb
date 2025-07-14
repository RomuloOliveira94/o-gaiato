Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  root "home#index"

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  resources :games, param: :game_code, only: [ :create, :show, :destroy ] do
    post :start, on: :member
    post :vote, on: :member
    delete :leave, on: :member
    get :player_data, on: :member
    post :kick_player, on: :member
    post :join, on: :collection
  end
end
