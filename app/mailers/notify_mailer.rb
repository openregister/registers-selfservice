class NotifyMailer < GovukNotifyRails::Mailer
  def api_key_confirmation(user)
    set_template('c8709881-610f-4618-8f8a-b3760721406a')

    set_personalisation(
      api_key: user.api_key
    )

    mail(to: user.email)
  end

  def new_api_key_request(user)
    set_template('926a72b2-1332-4e88-a322-adee7c522203')

    set_personalisation(
      email: user.email,
      api_key: user.api_key,
      department: user.department_name,
      non_gov_use_category: user.non_gov_use_category
    )

    mail(to: 'registerteam@digital.cabinet-office.gov.uk')
  end

  def register_download_confirmation(download_user)
    set_template('67a7d2f9-3faf-431a-a2a1-812f40a72e22')

    set_personalisation(
      register_name: download_user.register.capitalize,
      register_download_link: "https://www.registers.service.gov.uk/registers/#{download_user.register.parameterize}/download-csv"
    )

    mail(to: download_user.email)
  end
end
