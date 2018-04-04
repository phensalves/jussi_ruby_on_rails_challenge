class Participations < ActiveRecord::Migration[5.1]
  def change
  	create_table :participations do |t|
      t.belongs_to :comic_book, index: true
      t.belongs_to :character, index: true
      t.timestamps
    end
  end
end
