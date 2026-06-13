class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  how_many :books, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_one_attached :profile_image
end
