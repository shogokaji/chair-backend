class AddPermitionsToMessages < ActiveRecord::Migration[6.1]
  def change
    change_column :messages, :body, :string, limit:200, null: false
  end
end
