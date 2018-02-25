class CreateComicChars < ActiveRecord::Migration[5.1]
  def change
    create_table :comic_chars do |t|
      t.references :comic, foreign_key: true
      t.references :character, foreign_key: true

      t.timestamps
    end
  end
end
