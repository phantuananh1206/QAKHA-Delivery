class UserMailer < ApplicationMailer

  def password_reset user
    @user = user
    mail to: @user.email, subject: t("mailer.password_reset_title")
  end

  def password_forgot user
    @user = user
    mail to: @user.email, subject: t("mailer.forgot_password_title")
  end
end
