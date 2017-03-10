source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use mysql2 as the database for Active Record
gem 'mysql2',     '~> 0.4.4'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Various authentication gems
gem 'devise', '~> 4.2.0'
gem 'omniauth', '~> 1.3.1'
gem 'omniauth-facebook', '~> 4.0'
gem 'omniauth-google-oauth2', '~> 0.4.1'

# sparkpost is our email service
gem 'sparkpost_rails', '~> 1.4'

# sets up settings.yml and local env settings file
gem 'config', '~> 1.3'

# setting up paperclip and aws sdk to utilize s3
gem 'aws-sdk', '~> 2.6'
gem 'paperclip', '~> 5.1'

# rails pagination gem
gem 'kaminari', '~> 0.17'

# a quick sql OR query helper
gem 'activerecord_any_of', '~> 1.4'

# writing to PDFs
gem 'prawn', '0.12.0'

group :development, :test do
  # using binging.pry for inline debuggine
  gem 'pry-byebug'
  # app secret storage
  gem 'dotenv-rails'
  # Time-freezing & time-travel test util
  gem 'timecop'
  # Console tool and pretty console printing
  gem 'awesome_print'
  # Disable asset logging
  gem 'quiet_assets'
end

group :development do
  # better console debugging errors
  gem 'better_errors', '~> 2.1.1'
  gem 'binding_of_caller', '~> 0.7.2'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
