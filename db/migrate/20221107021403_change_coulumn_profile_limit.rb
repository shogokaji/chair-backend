class ChangeCoulumnProfileLimit < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :profile, :string, limit: 400
  end
end
