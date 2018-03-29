class CreateCharacters < ActiveRecord::Migration[5.1]
  def change
    create_table :characters do |t|
      t.integer :marvel_id
      t.string :name
      t.string :image
      t.datetime :modified

      t.timestamps
    end
  end
end
