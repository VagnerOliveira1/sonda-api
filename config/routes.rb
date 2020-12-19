Rails.application.routes.draw do
  resources :sondas, only: [:show], defaults: { format: 'json'}
end
