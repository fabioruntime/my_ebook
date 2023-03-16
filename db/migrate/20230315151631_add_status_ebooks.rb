class AddStatusEbooks < ActiveRecord::Migration[7.0]
  def change
    add_column :ebooks, :status, :integer, default: 0
  end
end
