class Api::V1::LikesController < ApplicationController
  before_action :set_diary

 def create
   like = current_api_v1_user.likes.find_or_initialize_by(diary_id:params[:diary_id])
  if like.save
    @diary.create_notification_like(current_api_v1_user)
    likes = []
    @diary.likes.each do |like|
      likes << like.user
    end
    render json:{ status: 200, likes:likes }
  else
    render json:{ status: 500, message:"登録に失敗しました。"}
  end
 end

 def destroy
  like = current_api_v1_user.likes.find_by(diary_id:params[:diary_id])
  like.destroy
  likes = []
  @diary.likes.each do |like|
    likes << like.user
  end
  render json:{ status: 200, likes:likes }
 end

 private

 def set_diary
  @diary = Diary.find(params[:diary_id])
 end

end
