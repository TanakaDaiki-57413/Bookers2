class Book < ApplicationRecord
  #アソシエーション設定
  belongs_to :user

  validates :title, presence: true
  validates :body, length: { maximum: 200 },presence:true
end
