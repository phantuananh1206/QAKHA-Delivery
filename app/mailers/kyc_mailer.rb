class KycMailer < ApplicationMailer
  def kyc object
    @object = object
    mail to: @object.email, subject: t('mailer.kyc.subject')
  end
end
