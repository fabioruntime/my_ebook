class CreateUserEbooks < ActiveRecord::Migration[7.0]
  def change
    create_table :user_ebooks do |t|
      t.integer :user_id
      t.integer :ebook_id
      t.timestamps
    end
  end
end
