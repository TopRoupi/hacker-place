source "https://rubygems.org"

ruby ">= 3.2.2"

gem "rails", "~> 7.1.2"
gem "sprockets-rails"
# gem "vite_rails"
gem "stimulus_reflex", ">= 3.5.0.rc4"
gem "pg"
gem "puma", ">= 5.0"
# gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "bootsnap", require: false

gem "redis-session-store", "~> 0.11.5"
gem "sidekiq", "~> 7.2"
gem "phlex-rails", "~> 1.1"
gem "phlex", ">= 1.9.2"
gem "devise", "~> 4.9"
gem "importmap-rails", "~> 2.0"

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"
# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"
# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"
# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby]

group :development, :test do
  gem "debug", platforms: %i[mri windows]
end

group :development do
  gem "web-console"
  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

gem "tailwindcss-rails", "~> 2.3"
