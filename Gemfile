source 'https://rubygems.org'

gem 'rails', '4.0.2'
gem 'haml'
gem 'faraday'
gem 'active_model_serializers'
gem 'puma'
gem 'dalli'
gem 'simple_form'
gem 'rack-cache'

group :assets do
  gem 'sass-rails',   '~> 4.0.0'
  gem 'coffee-rails', '~> 4.0.0'
  gem 'bourbon'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.3.0'
  gem 'jquery-rails'
end

group :production do
  gem 'memcachier'
  gem 'newrelic_rpm'
end

group :test do
  gem 'rspec-rails', '~> 2.14.0'
  gem 'capybara'
  gem 'poltergeist'
  gem 'timecop'
end

group :development, :test do
  gem 'foreman'
  gem 'pry-rails'
end
