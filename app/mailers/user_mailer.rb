class UserMailer < ApplicationMailer

  def password_reset user
    @user = user
    mail to: @user.email, subject: t("mailers.password_reset")
  end

  def password_forgot user
    @user = user
    mail to: @user.email, subject: "Forgot password"
  end
end
