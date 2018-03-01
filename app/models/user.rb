class User < ApplicationRecord

  before_save :set_uuid

  validates :email, presence: true

  private

  def set_uuid
    if self.uuid.blank?
      self.uuid = SecureRandom.uuid
    end
  end
end
