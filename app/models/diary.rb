class Diary < ApplicationRecord
  mount_uploader :image, ImageUploader
  
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :notifications, dependent: :destroy
  
  validates :title, presence: true, length: { maximum: 15 }
  validates :body, presence: true, length: { maximum: 400 }
  validates :user_id, presence: true

  def create_notification_like(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and diary_id = ? and action = ? ", current_user.id, user_id, id, 'like'])

    if temp.blank?
      notification = current_user.active_notifications.new(
        diary_id: id,
        visited_id: user_id,
        action: 'like'
      )
      notification.save if notification.valid?
    end
  end

  def create_notification_comment(current_user, comment_id, visited_id)
    if current_user.id != visited_id
      notification = current_user.active_notifications.build(
        diary_id: id,
        comment_id: comment_id,
        visited_id: visited_id,
        action: 'comment'
      )
      notification.save if notification.valid?
    end
  end


  scope :search_key_word, ->(key_word){
     where(
      'title LIKE(?) or body LIKE(?)', "%#{key_word}%","%#{key_word}%"
     ).order("created_at DESC")if key_word.present?
    }

  scope :not_owned, ->(user){
    where.not(user_id: user.id)
  }

  scope :published, ->(){
    where(publish: true)
  }

end
