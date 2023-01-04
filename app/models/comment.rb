class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :diary

  has_many :notifications, dependent: :destroy

  validates :text, presence: true, length: { maximum: 200 }
end
