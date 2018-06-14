require 'register_client_manager'

class User < ApplicationRecord
  nilify_blanks
  validates :contactable, inclusion: { in: [true, false] }, if: -> { is_government == true }
  validates :email, presence: true, if: -> { is_government == true }
  include ModelHelpers
  enum user_type: %i[api download]
end
