require 'register_client_manager'

class DownloadUser < ApplicationRecord
  nilify_blanks
  include ModelHelpers
  validates :email, presence: true
end
