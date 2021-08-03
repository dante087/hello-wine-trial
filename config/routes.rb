Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  # Api namespace
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users
      resources :orders
    end
  end
end
