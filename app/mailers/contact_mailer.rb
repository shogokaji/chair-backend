class ContactMailer < ApplicationMailer
  default from: ENV['EMAIL_ADDRESS']
  layout 'mailer'

  def send_mail(contact)
    @contact = contact
    mail(to: @contact.email, bcc: ENV['EMAIL_ADDRESS'], subject: 'お問合せについて【自動送信】')
  end
end
