class AddStatusUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :status, :integer, default: 0
  end
end
