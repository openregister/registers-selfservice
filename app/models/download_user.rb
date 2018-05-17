require 'register_client_manager'

class DownloadUser < ApplicationRecord
  nilify_blanks

  validates :email, presence: true

  def department_name
    if department.present?
      curie = department.split(':')
      registers_client = RegistersClient::RegisterClientManager.new
      register_data = registers_client.get_register(curie[0], 'beta')
      record = register_data.get_records.find { |r| curie[1] == r.entry.key }
      record.item.value['name']
    end
  end
end
