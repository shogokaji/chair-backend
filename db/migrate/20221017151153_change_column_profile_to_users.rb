class ChangeColumnProfileToUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :profile, :string, default:""
  end
end
