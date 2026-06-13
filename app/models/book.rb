class Book < ApplicationRecord
  #アソシエーション設定
  belongs_to :user
end
