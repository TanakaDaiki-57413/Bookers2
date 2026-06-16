class Book < ApplicationRecord
  #アソシエーション設定
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true
end
