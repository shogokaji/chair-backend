class Contact
  include ActiveModel::Model
  attr_accessor :name, :email, :body

  validates :name, presence: true, length: { maximum: 12 }
  validates :email, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 400 }
end
