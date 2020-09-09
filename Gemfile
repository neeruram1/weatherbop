source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'
gem 'rest-client'
gem 'faraday'
gem 'figaro'
gem 'rails', '~> 5.2.4', '>= 5.2.4.3'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'dotenv-rails'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false

group :test do
  gem 'vcr'
  gem 'webmock'
  gem 'capybara'
  gem 'launchy'
  gem 'rspec-rails'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rubocop-rails'
  gem 'simplecov'
  gem 'pry'
  gem 'shoulda-matchers'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'travis'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
