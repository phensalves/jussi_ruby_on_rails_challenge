class CreateOccurences < ActiveRecord::Migration[5.1]
  def change
    create_table :occurences do |t|
      t.belongs_to :character, index: true
      t.belongs_to :comic, index: true
    end
  end
end