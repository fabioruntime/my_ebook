class Ebook < ApplicationRecord
  has_many :ebook_authors
  has_many :authors, through: :ebook_authors
  has_many :user_ebook
  has_many :users, through: :user_ebook

  validates :title, presence: true
  validates :description, presence: true
end
