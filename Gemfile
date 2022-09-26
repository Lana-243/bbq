source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.4"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.3"
gem "sprockets-rails"
gem "carrierwave"
gem "rmagick"
gem 'devise'
gem 'pundit'
gem 'devise-i18n'
gem 'rails-i18n'
gem "puma", "~> 5.0"
gem "jbuilder"
gem "jsbundling-rails"
gem "turbo-rails", "~> 1.0.1"
gem "stimulus-rails"
gem "cssbundling-rails"
gem 'image_processing', "~> 1.2"
gem 'aws-sdk-s3'
gem 'rspec-rails'
gem 'shoulda-matchers'
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "sassc-rails"
gem 'mailjet'

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "sqlite3", "~> 1.4"
  gem 'factory_bot_rails'
end

group :development do
  gem "web-console"
end

group :production do
  gem "pg"
end
