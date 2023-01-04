class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  has_many :notifications

  validates :user_id, presence: true
  validates :room_id, presence: true
  validates :body, presence: true, length: { maximum: 200 }


  def create_notification_message(current_user,user_id)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ", current_user.id, user_id, 'message']).where(checked: false)

    if temp.blank?
      notification = current_user.active_notifications.build(
        visited_id: user_id,
        action: 'message'
      )
      notification.save if notification.valid?
    end
  end

end
