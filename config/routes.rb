Rails.application.routes.draw do
  root "welcome#index"

  get '/search', to: "search#show"

  namespace :api do
    namespace :v1 do
      resources :games, only: [:show]
    end
  end
end
