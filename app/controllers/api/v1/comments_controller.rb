class Api::V1::CommentsController < ApplicationController
  before_action :set_comment, only: %i[update destroy]

  def index
    comments = Comment.where(diary_id: comment_params[:diary_id])
    diary = Diary.find(comment_params[:diary_id])
    likes = []
    diary.likes.each do |like|
      likes << like.user
    end

    diaryData = {
      diary:,
      likes:,
      user: diary.user
    }
    commentData = []
    comments.each do |comment|
      commentData << {
        comment:,
        user: comment.user
      }
    end
    render json: { status: 200, comment: commentData, diary: diaryData }
  end

  def update
    if @comment.update(comment_params)
      data = {
        comment: @comment,
        user: @comment.user
      }
      render json: { status: 200, comment: data }
    else
      render json: { status: 500, message: '更新に失敗しました。' }
    end
  end

  def create
    comment = current_api_v1_user.comments.build(comment_params)
    if comment.save
      comment.diary.create_notification_comment(current_api_v1_user, comment.id, comment.diary.user_id)
      data = {
        comment:,
        user: comment.user
      }
      render json: { status: 200, comment: data }
    else
      render json: { status: 500, message: '問題が発生しました。' }
    end
  end

  def destroy
    @comment.destroy
    render json: { status: 200, comment: @comment }
  end

  def list
    user = User.find(params[:id])
    render json: { status: 200, comments: user.comments }
  end

  private

  def comment_params
    params.permit(:text, :diary_id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
