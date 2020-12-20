Rails.application.routes.draw do
  namespace :api,  defaults: { format: 'json' } do
    namespace :v1 do
      resources :sondas, only: [:show]
      get "/sondas/:id/reset", to: "sondas#reset"
      get "/sondas/:id/move" => "sondas#index"
    end
  end
end
