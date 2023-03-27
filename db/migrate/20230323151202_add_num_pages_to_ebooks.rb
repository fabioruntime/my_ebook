class AddNumPagesToEbooks < ActiveRecord::Migration[7.0]
  def change
    add_column :ebooks, :num_pages, :integer, default: 0
  end
end
