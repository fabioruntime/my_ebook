class Ebook < ApplicationRecord
  enum :status, { draft: 0, pending: 1, live: 2}

  has_one_attached :image, service: :cloudinary_ebooks
  has_one_attached :files, service: :cloudinary_ebooks_files
  has_many :ebook_authors
  has_many :authors, through: :ebook_authors
  has_many :user_ebook
  has_many :users, through: :user_ebook

  scope :coming, -> { where(status: :pending) }

  validates :title, presence: true, length: { minimum: 3, maximum: 150 }
  validates :description, presence: true
  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/,
                                      message: "Price must be equal 0 or greater 0.01" },
                                      numericality: { greater_than_or_equal_to: 0 }, :if => proc { |d| d.price.present? }

end
