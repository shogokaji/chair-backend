class Api::V1::RoomsController < ApplicationController

 def index 
  rooms = []
  target_rooms = current_api_v1_user.rooms.joins(:messages).includes(:messages).order("messages.created_at DESC")
  target_rooms.each do |room|
   rooms << {
    room: room, 
    other_user: room.users.where.not(id: current_api_v1_user.id)[0],
    last_message: room.messages[0]
   }
  end
   render json: { status: 200, rooms: rooms } 
 end

 def show
  @partner = User.find(params[:id])
  # 相手と自分のentryを全件取得
  own_entry = Entry.where(user_id: current_api_v1_user.id)
  partner_entry = Entry.where(user_id: @partner.id)
  # 比較相手が自身ではないことを担保
  if current_api_v1_user.id != @partner.id

   # 自身のentry一覧のroom_idを相手のentryのroom_idと比較
    own_entry.each do |own|
     partner_entry.each do |partner|
      if partner.room_id === own.room_id
        @room = Room.find(partner.room_id)
      end
     end
    end
    
    if @room
      #room内の相手のメッセージを全て既読に
      partner_messages = @room.messages.where(user_id: params[:id])
      partner_messages.each do |message|
        message.read = true
        message.save
      end
      
      messages = @room.messages.order("created_at ASC")
      
      data = {
        room_id: @room.id, 
        other_user: @partner, 
      }
      render json: { status: 200, data: data, messages: messages }
    else
      new_room = Room.create
      current_api_v1_user.entries.create(room_id: new_room.id)
      @partner.entries.create(room_id: new_room.id)
      data = {
        room_id: new_room.id, 
        other_user: @partner, 
      }
      render json: { status: 200, data: data, messages: [] }
    end

  else 
   render json: { status: 500, message: "問題が発生しました。" }
  end
 end


end
