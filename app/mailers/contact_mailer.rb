class ContactMailer < ApplicationMailer
 default from: ENV["EMAIL_ADDRESS"]
 layout 'mailer'

 def send_mail(contact,user)
   @contact = contact
   mail(to: user.email,bcc: ENV["EMAIL_ADDRESS"], subject: 'お問合せについて【自動送信】')
 end
end
