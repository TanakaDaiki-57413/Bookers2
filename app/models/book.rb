class Book < ApplicationRecord
  #アソシエーション設定
  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :book_comments,dependent: :destroy

  validates :title, presence: true
  validates :body, length: { maximum: 200 },presence:true

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
