require "sidekiq/web"

Rails.application.routes.draw do
  get "home/index"
  root "home#index"

  mount Sidekiq::Web, at: "sidekiq"
  resource :example, constraints: -> { Rails.env.development? }
  get "up" => "rails/health#show", as: :rails_health_check
end
