class NotifyMailer < GovukNotifyRails::Mailer
  def api_key_confirmation(user)
    set_template('c8709881-610f-4618-8f8a-b3760721406a')

    set_personalisation(
      api_key: user.api_key
    )

    mail(to: user.email)
  end
end
