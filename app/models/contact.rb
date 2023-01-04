class Contact include ActiveModel::Model
 attr_accessor :name, :body

 validates :name, presence: true, length: { maximum: 12 }
 validates :body, presence: true, length: { maximum: 400 }
end
