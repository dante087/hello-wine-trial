Rails.application.routes.draw do
  # Api namespace
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users
      resources :orders
    end
  end
end
