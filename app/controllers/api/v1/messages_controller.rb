class Api::V1::MessagesController < ApplicationController

 def show
    messages = Message.where(user_id: params[:id]).order("room_id DESC")
    render json: { status: 200, messages: messages }
 end

 def create
  message = current_api_v1_user.messages.create(message_params)
  other_user  = message.room.users.where.not(id: current_api_v1_user.id)[0]
  message.create_notification_message(current_api_v1_user,other_user.id)
  render json:{ status: 200, message: message }
 end

 def destroy
  message=Message.find(params[:id])
  message.destroy
  render json:{ status: 200 }
 end

  private

  def message_params
   params.permit(:body, :room_id)
  end

end
