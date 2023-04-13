class Ebook < ApplicationRecord
  enum :status, { draft: 0, pending: 1, live: 2 }

  has_one_attached :image, service: :cloudinary_ebooks
  has_one_attached :files, service: :cloudinary_ebooks_files
  has_many :ebook_authors
  has_many :authors, -> { distinct }, through: :ebook_authors
  has_many :user_ebook
  has_many :users, through: :user_ebook

  scope :coming, -> { where(status: :pending) }

  validates :title, presence: true, length: { minimum: 3, maximum: 150 }
  validates :description, presence: true, length: { maximum: 10000 }
  validates :date_release, presence: true
  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }
  validates_numericality_of :price, greater_than: 0, message: "Price must be greater than 0.01", if: proc { |d| d.price.present? }
end
