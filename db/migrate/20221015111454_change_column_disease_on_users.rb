class ChangeColumnDiseaseOnUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :disease, :string, limit: 25
  end
end
