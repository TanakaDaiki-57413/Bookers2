class Book < ApplicationRecord
  #アソシエーション設定
  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy
  has_many :book_comments,dependent: :destroy
  has_many :view_counts,dependent: :destroy

  validates :title, presence: true
  validates :body, length: { maximum: 200 },presence:true

  scope :popular_in_last_week, -> {
    left_joins(:favorites) # Bookと「いいね」を結びつけて「いいね」の情報を取り出す
      .where('favorites.created_at >= ?', 1.week.ago) #過去1週間の「いいね」だけを対象にする
      .or(
      Book.left_joins(:favorites)
          .where(favorites: { id: nil })
      )
      .group('books.id') # 各Bookごとに「いいね」をまとめる
      .order('COUNT(favorites.id) DESC') # 「いいね」の数が多い順に並び替える
  }

  after_create do
    user.followers.each do |follower|
      notifications.create(user_id: follower.id)
    end
  end  

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
