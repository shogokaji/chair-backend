class Like < ApplicationRecord
 belongs_to :user
 belongs_to :diary

 scope :liked_diaries, ->(){
  group(:diary_id)
  .order('count(diary_id) desc')
  .pluck(:diary_id)
}
end
