class Author < ApplicationRecord
  has_many :ebook_authors
  has_many :ebooks, through: :ebook_authors
end
