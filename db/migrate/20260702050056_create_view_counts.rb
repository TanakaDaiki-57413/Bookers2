class CreateViewCounts < ActiveRecord::Migration[8.1]
  def change
    create_table :view_counts do |t|
      t.references :book, null: false,foreign_key: true
      t.integer :view_count
      t.timestamps
    end
  end
end
