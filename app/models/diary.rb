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
    temp = Notification.where(
      ['visitor_id = ? and visited_id = ? and diary_id = ? and action = ? ', 
        current_user.id,
        user_id, id, 'like'
      ]
    )
    return unless temp.blank?

    notification = current_user.active_notifications.new(
      diary_id: id,
      visited_id: user_id,
      action: 'like'
    )
    notification.save if notification.valid?
  end

  def create_notification_comment(current_user, comment_id, visited_id)
    return unless current_user.id != visited_id

    notification = current_user.active_notifications.build(
      diary_id: id,
      comment_id:,
      visited_id:,
      action: 'comment'
    )
    notification.save if notification.valid?
  end

  scope :search_key_word, lambda { |key_word|
                            if key_word.present?
                              where(
                                'title LIKE(?) or body LIKE(?)', "%#{key_word}%", "%#{key_word}%"
                              ).order('created_at DESC')
                            end
                          }

  scope :not_owned, lambda { |user|
    where.not(user_id: user.id)
  }

  scope :published, lambda {
    where(publish: true)
  }
end
