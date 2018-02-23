class CreateCharacters < ActiveRecord::Migration[5.1]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :modified
      t.integer :marvel_id
      t.string :image_path
      t.text :description

      t.timestamps
    end
  end
end
