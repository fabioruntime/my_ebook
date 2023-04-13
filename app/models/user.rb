class User < ApplicationRecord
  enum :status, { disable: 0, enable: 1 }

  has_one_attached :avatar, service: :cloudinary_profiles
  has_many :user_ebook
  has_many :ebooks, through: :user_ebook

  validates :name, presence: true
  validates :username,
    presence: true,
    uniqueness: { case_sensitive: false },
    length: { minimum: 3, maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false },
    length: { maximum: 105 },
    format: { with: VALID_EMAIL_REGEX, message: "Incorrect email format" }
  has_secure_password
  validates :password, length: { minimum: 8 }, if: :password_digest_changed?
end
