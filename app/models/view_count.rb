class ViewCount < ApplicationRecord
  belongs_to :book

  validates :book_id, uniqueness: {scope: :book_id}

  def self.count_up_view(book)
    record_target = ViewCount.find_by(book_id:book.id)
    count = record_target.view_count
    count +=1
    record_target.update(view_count:count)
  end

  def self.add_count_view(book)
    new_count = ViewCount.new(view_count:1,book_id:book.id)
    new_count.save
  end

end
