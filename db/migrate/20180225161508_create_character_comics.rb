class CreateCharacterComics < ActiveRecord::Migration[5.1]
  def change
    create_table :character_comics do |t|
      t.references :character, foreign_key: true
      t.references :comic, foreign_key: true

      t.timestamps
    end
  end
end
