class AddColumnUserIsGest < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :is_gest, :boolean, null: false, default: false
  end
end
