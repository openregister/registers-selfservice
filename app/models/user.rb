require 'register_client_manager'

class User < ApplicationRecord
  before_save :set_api_key
  nilify_blanks
  validates :email, presence: true
  include ModelHelpers

private

  def set_api_key
    if self.api_key.blank?
      self.api_key = SecureRandom.uuid
    end
  end
end
