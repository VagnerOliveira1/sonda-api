Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :sondas, only: [:show], defaults: { format: 'json'}
    end
  end
end
