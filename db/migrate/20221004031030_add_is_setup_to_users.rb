class AddIsSetupToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :is_setup, :boolean,null:false,default:false
  end
end
