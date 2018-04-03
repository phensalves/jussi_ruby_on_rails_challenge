class AddResourcesToCharacters < ActiveRecord::Migration[5.1]
  def change
    enable_extension "hstore"
    add_column :characters, :resources, :hstore, array: true, default: []
  end
end
