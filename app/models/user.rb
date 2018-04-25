require 'register_client_manager'

class User < ApplicationRecord
  before_save :set_api_key
  nilify_blanks

  validates :email, presence: true

  def department_name
    if department.present?
      registers_client = RegistersClient::RegisterClientManager.new
      register_data = registers_client.get_register('government-organisation', 'beta')
      record = register_data.get_records.find { |r| department == r.entry.key }
      record.item.value['name']
    end
  end

private

  def set_api_key
    if self.api_key.blank?
      self.api_key = SecureRandom.uuid
    end
  end
end
