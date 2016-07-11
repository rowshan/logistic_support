source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  gem 'listen', '~> 3.0.5'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'active_model_serializers', github: 'rails-api/active_model_serializers'
gem 'dotenv-rails', groups: [:development, :test]

group :development, :test do
  gem 'rspec-rails', '~>3.5'
  gem 'rails-controller-testing'
  gem 'factory_girl_rails'

end


gem 'simplecov', require: false, group: :test

# This needs to be removed once 2.0 is released and can be added as a dependency
# It is required by ApiM8
gem 'rest-client', github: 'rest-client/rest-client', branch: :master
gem 'api_m8', git: 'git@bitbucket.org:jonnyfresh/api_m8.git', branch: :master
