class NotificationMailer < ApplicationMailer

  layout 'mailer'

  def notification(email_cliente)
    email = email_cliente
    mail to: email, subject: "Olá! Conheça nossas promoções!"
  end

end
