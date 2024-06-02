require "sidekiq/web"

Rails.application.routes.draw do
  devise_for :players
  get "home/index"
  get 'monitoring/scripts', as: :monitoring_scripts
  root "home#index"

  get 'codicon.ttf', to: redirect('https://cdn.jsdelivr.net/npm/monaco-editor@0.45.0/esm/vs/base/browser/ui/codicons/codicon/codicon.ttf')
  mount Sidekiq::Web, at: "sidekiq"
  resource :example, constraints: -> { Rails.env.development? }
  get "up" => "rails/health#show", :as => :rails_health_check
end
