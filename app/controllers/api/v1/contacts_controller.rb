class Api::V1::ContactsController < ApplicationController

  def create
    @contact = Contact.new(contact_params)
    ContactMailer.send_mail(@contact).deliver_now
    render json:{status: 200, message: "お問合せを送信しました。"}
  end


 private

  def contact_params
  params.require(:contact).permit(:name, :body, :email)
  end
end
