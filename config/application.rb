require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
# require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_view/railtie"
# require "action_cable/engine"
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RegistersSelfservice
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Don't generate system test files.
    config.generators.system_tests = nil
    config.active_job.queue_adapter = :delayed_job

    if ENV.key?('VCAP_SERVICES')
      cups_env = CF::App::Credentials.find_by_service_name('registers-selfservice-secrets')
      if cups_env.present?
        cups_env.each { |k, v| ENV[k] = v }
      end
    end


    # Use GovukNotify
    ActionMailer::Base.add_delivery_method :govuk_notify, GovukNotifyRails::Delivery, api_key: ENV['GOVUK_NOTIFY_API_KEY']
  end
end
