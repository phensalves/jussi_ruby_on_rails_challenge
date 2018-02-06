class CreateComics < ActiveRecord::Migration[5.1]
  def change
    create_table :comics do |t|
      t.string :title
      t.string :modified
      t.integer :issue_number
      t.integer :marvel_id
      t.string :image_path
      t.text :description

      t.timestamps
    end
  end
end
