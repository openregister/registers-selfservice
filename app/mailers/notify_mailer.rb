class NotifyMailer < GovukNotifyRails::Mailer
  def api_key_confirmation(user)
    set_template('c8709881-610f-4618-8f8a-b3760721406a')

    set_personalisation(
      api_key: user.api_key
    )

    mail(to: user.email)
  end

  def api_key_inactive_deletion(user)
    set_template('035555bd-ae6a-409b-b5ca-47aa35eefe64')

    set_personalisation(
      api_key: user.api_key
    )

    mail(to: user.email)
  end

  def api_key_inactive_warning(user)
    set_template('01a7bf75-62be-4c0f-bcd9-261fe0ce7349')

    set_personalisation(
      api_key: user.api_key
    )

    mail(to: user.email)
  end
end
