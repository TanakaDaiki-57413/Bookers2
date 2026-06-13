class CreateBooks < ActiveRecord::Migration[8.1]
  def change
    create_table :books do |t|
      t.references :user,foreign_key: true
      t.string :title
      t.string :body
      t.timestamps
    end
  end
end
