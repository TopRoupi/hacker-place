require "sidekiq/web"

Rails.application.routes.draw do
  resource :example, constraints: -> { Rails.env.development? }
  get "up" => "rails/health#show", :as => :rails_health_check
  mount PgHero::Engine, at: "pghero"
  mount Sidekiq::Web, at: "sidekiq"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"
  resources :sessions, only: [:index, :show, :destroy]
  resource :password, only: [:edit, :update]
  namespace :identity do
    resource :email, only: [:edit, :update]
    resource :email_verification, only: [:show, :create]
    resource :password_reset, only: [:new, :edit, :create, :update]
  end

  get "home/index"
  get "monitoring/scripts", as: :monitoring_scripts
  root "home#index"

  get "codicon.ttf", to: redirect("https://cdn.jsdelivr.net/npm/monaco-editor@0.45.0/esm/vs/base/browser/ui/codicons/codicon/codicon.ttf")
end
