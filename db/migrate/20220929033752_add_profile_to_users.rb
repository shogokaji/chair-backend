class AddProfileToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :sex, :integer, null:false, default:0
    add_column :users, :age, :integer,null:false,default:0
    add_column :users, :department, :integer,null:false,default:0
    add_column :users, :disease, :string
    add_column :users, :favorite, :string
    add_column :users, :profile, :text
    add_column :users, :admin, :boolean,null:false,default:false
  end
end
