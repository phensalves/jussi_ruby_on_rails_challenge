class ComicBooks < ActiveRecord::Migration[5.1]
  def change
  	create_table :comic_books do |t|
      t.string :title
      t.integer :cover_number
      t.string :image
      
      t.timestamps
    end
  end
end
