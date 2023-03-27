class AddPriceToEbooks < ActiveRecord::Migration[7.0]
  def change
    add_column :ebooks, :price, :decimal, precision: 6, scale: 2
  end
end
