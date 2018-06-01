require 'register_client_manager'

class User < ApplicationRecord
  before_save :set_api_key
  nilify_blanks
  validates :contactable, inclusion: { in: [true, false] }, if: -> { is_government == true }
  validates :email, presence: true, if: -> { is_government == true }
  include ModelHelpers

private

  def set_api_key
    if self.api_key.blank?
      self.api_key = SecureRandom.uuid
    end
  end
end
