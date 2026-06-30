class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  # アソシエーション設定
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments,dependent: :destroy
  has_many :relationships,class_name: "Relationship",foreign_key: "follower_id",dependent: :destroy
  has_many :followings,through: :relationships,source: :followed

  has_many :reverse_of_relationships,class_name: "Relationship",foreign_key: "followed_id",dependent: :destroy
  has_many :followers, through: :reverse_of_relationships,source: :follower

  has_many :user_rooms, dependent: :destroy
  has_many :chats,dependent: :destroy
  has_many :room,through: :user_rooms

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_one_attached :profile_image

  validates :name, presence: true,length: { minimum: 2 ,maximum: 20 },uniqueness: true
  validates :introduction,length: {maximum:50}
  validates :password,length: { minimum: 6 },allow_nil: true

  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    
    find_or_create_by!(email_address: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end 
    
  end

  def guest_user?
    email_address == GUEST_USER_EMAIL
  end

  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_fill: [width, height]).processed
  end

  def follow(user)
    relationships.create(followed_id:user.id)
  end

  def unfollow(user)
    relationships.find_by(followed_id:user.id).destroy
  end

  def following?(user)
    followings.include?(user)
  end


end
