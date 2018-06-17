source 'https://rubygems.org'

ruby File.read('.ruby-version').split('@').first.strip

git_source(:github) do |repo_name|
  repo_name = '#{repo_name}/#{repo_name}' unless repo_name.include?('/')
  'https://github.com/#{repo_name}.git'
end

gem 'rails', '~> 5.2.0'
gem 'puma'
# TODO: Get rid of this since we use webpakckk
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
gem 'bulma-rails', '~> 0.6.2'
gem 'webpacker', '~> 3.2'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'mongoid', '~> 7.0.0'
gem 'devise'
gem 'omniauth-github'
gem 'omniauth-twitter'
gem 'sidekiq'
gem 'bugsnag'
gem 'twilio-ruby', '~> 4.11.1'
gem 'stripe'
gem 'slack-notifier'
gem 'hipchat'
gem 'kaminari', '~> 1.0'
gem 'kaminari-mongoid'
gem 'whenever', :require => false
gem 'influxdb'
gem 'redis-rails'
gem 'redis', '~>3.2'
gem 'connection_pool'
gem 'request_store'

gem 'newrelic_rpm'
gem 'rails_admin', :git => 'https://github.com/sferik/rails_admin'

group :development, :test do
  gem 'awesome_print'
  gem 'bootsnap', require: false
  gem 'byebug', platform: :mri

  gem 'capistrano'
  gem 'capistrano-rvm'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'factory_bot_rails'

  gem 'pry-rails'
  gem 'pry'
  gem 'rubocop'
  gem 'rspec-rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem "database_cleaner"
  gem "rspec_junit_formatter"
  gem "capybara"
  gem "webmock", require: false
  gem "timecop"
end
