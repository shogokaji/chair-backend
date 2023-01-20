class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :diary

  has_many :notifications, dependent: :destroy

  validates :text, presence: true, length: { maximum: 200 }

  scope :commented_diaries, lambda {
    group(:diary_id)
      .order('count(diary_id) desc')
      .pluck(:diary_id)
  }
end
