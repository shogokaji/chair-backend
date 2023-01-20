class User < ActiveRecord::Base
  extend Devise::Models
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable, :validatable, :trackable

  include DeviseTokenAuth::Concerns::User

  mount_uploader :image, ImageUploader

  validates :name, presence: true, length: { maximum: 12 }
  validates :department, presence: true
  validates :disease, length: { maximum: 25 }
  validates :favorite, length: { maximum: 25 }
  validates :profile, length: { maximum: 200 }

  has_many :diaries, dependent: :destroy

  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy

  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy

  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :rooms, through: :entries

  has_many :active_notifications, class_name: 'Notification',
                                  foreign_key: 'visitor_id',
                                  dependent: :destroy

  has_many :passive_notifications, class_name: 'Notification',
                                   foreign_key: 'visited_id',
                                   dependent: :destroy

  scope :search_department, ->(department) { where(department:) if department.present? }

  scope :search_age, ->(age) { where(age:) if age.present? }

  scope :search_sex, ->(sex) { where(sex:) if sex.present? }

  scope :search_key_word, lambda { |key_word|
    if key_word.present?
      where(
        'name LIKE(?) or profile LIKE(?) or disease LIKE(?) or favorite LIKE(?)', "%#{key_word}%", "%#{key_word}%", "%#{key_word}%", "%#{key_word}%"
      )
    end
  }

  # フォロー
  def follow(other_user)
    followings << other_user
  end

  # フォロー解除
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    followings.include?(other_user)
  end

  def create_notification_follow(current_user)
    temp = Notification.where(['visitor_id = ? and visited_id = ? and action = ? ', current_user.id, id, 'follow'])
    return unless temp.blank?

    notification = current_user.active_notifications.build(
      visited_id: id,
      action: 'follow'
    )
    notification.save if notification.valid?
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.confirmed_at = Time.now
      user.name = 'ゲストユーザー'
      user.is_gest = true
      user.profile = 'ゲストユーザーでは一部の機能に制限がありますが、アプリの様子を確認できます。'
    end
  end
end
