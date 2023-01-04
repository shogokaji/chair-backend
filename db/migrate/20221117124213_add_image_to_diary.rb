class AddImageToDiary < ActiveRecord::Migration[6.1]
  def change
    add_column :diaries, :image, :string
  end
end
