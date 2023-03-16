class Ebook < ApplicationRecord
  enum :status, { draft: 0, pending: 1, live: 2}

  has_many :ebook_authors
  has_many :authors, through: :ebook_authors
  has_many :user_ebook
  has_many :users, through: :user_ebook

  validates :title, presence: true
  validates :description, presence: true
end
