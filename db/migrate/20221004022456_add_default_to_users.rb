class AddDefaultToUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :department, from: nil, to: 0
  end
end
