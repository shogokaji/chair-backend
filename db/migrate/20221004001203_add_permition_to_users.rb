class AddPermitionToUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :name, :string, null: false,limit: 12
    change_column :users, :email, :string, null: false
    change_column_default :users, :department, from: 0, to: nil
    change_column :users, :disease, :string, limit:50,null:false,default:""
    change_column :users, :favorite, :string, limit:50,null:false,default:""
    change_column :users, :profile, :string, limit:250,null:false,default: "よろしくお願いします。"
    remove_column :users, :nickname, :string 
  end
end
