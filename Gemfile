source 'https://rubygems.org'

ruby '2.0.0'

# Project requirements
gem 'rake'
gem 'rails_12factor'

# Component requirements
gem 'bcrypt'
gem 'slim'

group :development, :test do
  gem 'pry-padrino'
  gem 'sqlite3'
end

# DB requirements
gem 'pg', :group => 'production'
gem 'activerecord', '>= 3.1', :require => 'active_record'

# Test requirements
group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'poltergeist'
  gem 'launchy'
  gem 'factory_girl'
  gem 'rack-test', :require => 'rack/test'
  gem 'database_cleaner'
end

# Padrino Stable Gem
gem 'padrino', '0.12.3'
