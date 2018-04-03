class ApplicationController < ActionController::API
  include ActionController::Serialization

  include ActionController::HttpAuthentication::Basic::ControllerMethods
  http_basic_authenticate_with name: Rails.application.secrets.http_auth_username, password: Rails.application.secrets.http_auth_password
end
