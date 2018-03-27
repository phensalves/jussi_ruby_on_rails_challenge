class CreateComics < ActiveRecord::Migration[5.1]
  def change
    create_table :comics do |t|
      t.string :title
      t.integer :cover
      t.string :image

      t.timestamps
    end
  end
end
