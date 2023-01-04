class CreateDiaries < ActiveRecord::Migration[6.1]
  def change
    create_table :diaries do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.boolean :publish, null: false, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :diaries,[:user_id, :created_at]
  end
end
