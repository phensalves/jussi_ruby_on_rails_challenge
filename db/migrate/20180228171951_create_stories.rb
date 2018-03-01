class CreateStories < ActiveRecord::Migration[5.1]
  def change
    create_table :stories do |t|
      t.integer :marvel_id
      t.integer :character_id
      t.integer :marvel_characters_id
      t.string :title
      t.text :description, default: nil
      t.string :thumbnail, default: nil

      t.timestamps
    end
  end
end
