class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[update destroy show likes]

  def index
    users = User.where.not(id: current_api_v1_user.id).order('created_at DESC')
    render json: { status: 200, users: }
  end

  def update
    @user.name = user_params[:name]
    @user.sex = user_params[:sex]
    @user.age = user_params[:age]
    @user.department = user_params[:department]
    @user.disease = user_params[:disease]
    @user.favorite = user_params[:favorite]
    @user.profile = user_params[:profile]
    @user.image = user_params[:image] unless user_params[:image].nil?
    if @user.save
      render json: { status: 200, user: @user }
    else
      render json: { status: 500, message: '更新に失敗しました' }
    end
  end

  def set_up
    current_api_v1_user.update(is_setup: true)
    render json: { status: 200, message: 'セットアップが完了しました' }
  end

  def destroy
    @user.destroy
    render json: { status: 200, data: @user, message: '削除成功' }
  end

  def show
    if @user
      render json: {
        status: 200,
        user: @user,
        follows: @user.followings,
        followers: @user.followers
      }
    else
      render json: { status: 500, message: 'ユーザーが見つかりませんでした。' }
    end
  end

  #  ユーザーがフォローしているユーザー一覧
  def followings
    @user  = User.find(params[:id])
    @users = @user.following
  end

  # ユーザーをフォローしているユーザー一覧
  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
  end

  # ユーザーがいいねした日記一覧
  def likes
    diaries = []
    @user.likes.each do |like|
      diary = Diary.find(like.diary_id)
      likes = []
      diary.likes.each do |like|
        likes << like.user
      end
      diaries << {
        diary:,
        user: diary.user,
        likes:,
        comments: diary.comments
      }
    end
    render json: { status: 200, diaries: }
  end

  def search
    users =
    User.where(is_gest: false).search_department(user_params[:department])
        .search_age(user_params[:age])
        .search_sex(user_params[:sex])
        .search_key_word(user_params[:key_word])

    render json: { status: 200, users: }
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:name, :sex, :age, :department, :disease, :favorite, :profile, :image, :key_word)
  end
end
