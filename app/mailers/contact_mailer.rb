class ContactMailer < ApplicationMailer
  def contact(email, name, content)
    @email = email
    @name = name
    @content = content
    mail to: Settings.mailer.email, subject: t('mailer.contact.subject')
  end

  def inform(email, name)
    @email = email
    @name = name
    mail to: @email, subject: t('mailer.inform.subject')
  end
end
