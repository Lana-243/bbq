source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.4'

gem 'aws-sdk-s3'
gem 'carrierwave'
gem 'cssbundling-rails'
gem 'devise'
gem 'devise-i18n'
gem 'image_processing', '~> 1.2'
gem 'jbuilder'
gem 'jsbundling-rails'
gem 'mailjet'
gem 'puma', '~> 5.0'
gem 'pundit'
gem 'rails', '~> 7.0.3'
gem 'rails-i18n'
gem 'rmagick'
gem 'rspec-rails'
gem 'sassc-rails'
gem 'shoulda-matchers'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails', '~> 1.0.1'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'sqlite3', '~> 1.4'
end

group :development do
  gem 'web-console'
end

group :production do
  gem 'pg'
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
