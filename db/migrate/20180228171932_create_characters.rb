class CreateCharacters < ActiveRecord::Migration[5.1]
  def change
    create_table :characters do |t|
      t.integer :marvel_id
      t.string :name
      t.string :description, default: nil
      t.timestamp :modified, default: nil
      t.string :thumbnail, default: nil

      t.timestamps
    end
  end
end
