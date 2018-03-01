class User < ApplicationRecord

  before_save :set_uuid

  private

  def set_uuid
    if self.uuid.blank?
      self.uuid = SecureRandom.uuid
    end
  end
end
