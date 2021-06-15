class UserMailer < ApplicationMailer

  def password_reset user
    @user = user
    mail to: @user.email, subject: t("mailer.password_reset_title")
  end

  def password_forgot user
    @user = user
    mail to: @user.email, subject: t("mailer.forgot_password_title")
  end

  def resend_email_change user
    @user = user
    mail to: @user.unconfirmed_email, subject: "Confirmation instructions"
  end
end
