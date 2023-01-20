class ChangeColumnProfileOnUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :profile, :string, limit: 200
  end
end
