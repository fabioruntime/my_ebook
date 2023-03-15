class EbookAuthor < ApplicationRecord
  belongs_to :ebook
  belongs_to :author
end
