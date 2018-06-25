source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby File.read(".ruby-version").chomp

gem 'rails', '~> 5.1.4'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'active_model_serializers'
gem 'google-api-client'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# Email and Text Notifications
gem 'govuk_notify_rails'

# Cloudfoundry ruby helper
gem 'cf-app-utils'

gem 'govuk-registers-api-client', '~> 1.0'
gem 'nilify_blanks', '~> 1.3'

# scheduled tasks
gem 'clockwork', '~> 2.0', '>= 2.0.3'
gem 'delayed_job_active_record', '~> 4.1', '>= 4.1.3'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'pry-byebug'

  gem 'rspec-rails', '~> 3.5'

  gem 'govuk-lint', '~> 3.8'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
end

group :test do
  gem 'factory_bot_rails', '~> 4.0'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'faker'
  gem 'database_cleaner'
end

group :production do
  gem 'lograge', '~> 0.10.0'
  gem 'logstash-event', '~> 1.2'
  gem 'health_check', '~> 3.0'
end
