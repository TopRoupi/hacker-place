source "https://rubygems.org"

ruby ">= 3.2.2"

gem "rails", "~> 7.1.2"
gem "pg"
gem "puma", ">= 5.0"

gem "sprockets-rails"
gem "importmap-rails", "~> 2.0"
gem "tailwindcss-rails", "~> 2.3"

gem "turbo-rails"
gem "stimulus-rails"
gem "phlex-rails", "~> 1.1"
gem "phlex", ">= 1.9.2"
gem "stimulus_reflex", ">= 3.5.0.rc4"

gem "authentication-zero", "~> 3.0"
gem "bcrypt", "~> 3.1.7"

gem "drb", "~> 2.2"
gem "redis-session-store", "~> 0.11.5"
gem "sys-proctable"
gem "sidekiq", "~> 7.2"

# gem "jbuilder"
# gem "redis", ">= 4.0.1"
# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"
# gem "image_processing", "~> 1.2"

group :development, :test do
  gem "debug", platforms: %i[mri windows]
  gem "factory_bot_rails"
end

group :development do
  gem "database_consistency", require: false
  gem "web-console"
  gem "annotate", git: "https://github.com/ctran/annotate_models.git"
  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  gem "spring"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "simplecov", require: false
end

gem "tzinfo-data", platforms: %i[windows jruby]
gem "bootsnap", require: false

gem "model_probe", "~> 1.1"
