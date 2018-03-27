class CreateJoinTableCharacterComic < ActiveRecord::Migration[5.1]
  def change
    create_join_table :characters, :comics
  end
end
