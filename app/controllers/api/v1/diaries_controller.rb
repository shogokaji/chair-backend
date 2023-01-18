class Api::V1::DiariesController < ApplicationController
 before_action :set_user, only: %i[  show ]
 before_action :set_diary, only: %i[ destroy update ]

  def index
    diaries=[]
    diariesList = Diary.not_owned(current_api_v1_user).published.order(created_at: :DESC)
    diariesList.each do |diary|
      likes = []
      diary.likes.each do |like|
        likes << like.user
      end
      diaries << {
        diary: diary,
        user: diary.user, 
        likes: likes,
        comments: diary.comments 
      }
    end
    render json:{ status: 200, diaries: diaries }
  end

  def show
  diaries = []
  user_diaries = @user.diaries.order(created_at: :DESC)
  user_diaries.each do |diary|
      likes = []
      diary.likes.each do |like|
        likes << like.user
      end
      diaries << {
        diary: diary,
        user: diary.user,
        likes: likes,
        comments: diary.comments
      }
    end
  render json:{ status: 200, diaries: diaries}
  end

  def create
  diary = current_api_v1_user.diaries.build(diary_params)
  if diary.save
    render json:{ status: 200, diary: diary}
  else
    render json:{ status: 500, message: 作成に失敗しました。}
  end
  end

def update
  if @diary.update(diary_params)
    render json: {status: 200, diary: @diary}
  else
    render json: {status: 500, message: 編集に失敗しました。}
  end
end

def destroy
  @diary.destroy
  render json:{status: 200, diary: @diary}
end


#フォロー中のユーザーの日記のみを取得
def relational_diaries
  diaries=[]
  diariesList = Diary.where(user_id:current_api_v1_user.following_ids).order(created_at: :DESC)
  diariesList.each do |diary|
    likes = []
    diary.likes.each do |like|
      likes << like.user
    end
    diaries << {
      diary: diary,
      user: diary.user,
      likes: likes,
      comments: diary.comments
    }
  end
  render json: {status: 200, diaries: diaries}
end

  def search
    diariesList = Diary.search_key_word(diary_params[:key_word]).not_owned(current_api_v1_user).published
    diaries=[]
    diariesList.each do |diary|
      likes = []
      diary.likes.each do |like|
        likes << like.user
      end
      diaries << {
        diary: diary,
        user: diary.user,
        likes: likes,
        comments: diary.comments
      }
    end
    
    render json:{ status: 200, diaries: diaries }
  end

  
  def sort
    publicDiaries = Diary.published
    if diary_params[:sort] == "like" 
      diariesList = publicDiaries.where(id:[Like.liked_diaries])
    elsif diary_params[:sort] == "comment"
      diariesList = publicDiaries.where(id:[Comment.commented_diaries])
    elsif diary_params[:sort] == "day"
      diariesList = publicDiaries.where(created_at: Time.zone.now.all_day)
    end

    diaries=[]
    diariesList.each do |diary|
      likes = []
      diary.likes.each do |like|
        likes << like.user
      end
      diaries << {
        diary: diary,
        user: diary.user,
        likes: likes,
        comments: diary.comments
      }
    end
     
    render json:{ status: 200, diaries:diaries}
  end

 private

def diary_params
  params.permit(:title, :body, :publish, :user_id, :image, :department, :key_word, :sort)
end

def set_diary
 @diary = Diary.find(params[:id])
end

def set_user
 @user = User.find(params[:id])
end

end
