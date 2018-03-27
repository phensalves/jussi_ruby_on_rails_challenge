class CreateCharacters < ActiveRecord::Migration[5.1]
  def change
    create_table :characters, id: false do |t|
      t.primary_key :marvel_id
      t.string :name
      t.string :image
      t.datetime :modified

      t.timestamps
    end
  end
end
