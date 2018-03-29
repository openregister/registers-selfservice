Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins Rails.configuration.registers_frontend_host
    resource '*',
      headers: :any,
      methods: %i(post options head)
  end
end
