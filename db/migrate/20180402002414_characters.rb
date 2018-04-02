class Characters < ActiveRecord::Migration[5.1]
  def change
  	create_table :characters do |t|
      t.integer :id_marvel
      t.string :name
      t.string :image
      
      t.timestamps
    end
  end
end
