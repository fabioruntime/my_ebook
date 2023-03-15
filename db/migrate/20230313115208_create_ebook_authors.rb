class CreateEbookAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :ebook_authors do |t|
      t.integer :ebook_id
      t.integer :author_id
      t.timestamps
    end
  end
end
