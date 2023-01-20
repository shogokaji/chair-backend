class ChangeColumnLimitOnUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :favorite, :string, limit: 25
  end
end
