Rails.application.routes.draw do
  root "welcome#index"

  get '/search', to: "search#show"

  namespace :api do
    namespace :v1 do
      resources :games, only: [:show] do
        resources :plays, only: [:create]
      end
    end
  end
end
