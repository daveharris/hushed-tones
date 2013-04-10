source 'https://rubygems.org'

gem 'rails', '~> 3.2'
gem 'sqlite3'

gem 'jquery-rails'

gem 'letmein'

group :development do
  gem 'thin'
  gem 'rspec-rails'
end

group :test do
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i  
  gem 'guard-rspec'
end

group :assets do
  gem 'bootstrap-sass'
  gem 'bootswatch-rails'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'uglifier', '>= 1.0.3'
end
