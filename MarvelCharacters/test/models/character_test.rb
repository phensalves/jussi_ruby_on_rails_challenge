require 'test_helper'

class CharacterTest < ActiveSupport::TestCase
  self.use_transactional_tests = true

  test "a character can have more than one comic" do
    character = characters(:a_character)

    occurences = Occurence.where(:character_id => character.id)
    
    assert_operator occurences.length, :>=, 1
  end

  test "a character should not be saved when database already have a character with a given marvel_id" do
    another_character = Character.new(
      :name => "Iron Man",
      :marvel_id => 42,
      :modified => "Modified-String-2",
      :image_path => "The another_comic cover URL",
      :description => "The another_comic description"
    )
  
   assert_not_equal characters(:a_character), another_character
   assert_not_equal characters(:another_character), another_character
   assert_not another_character.save
  end

  test "a character should not be saved without name" do
    character = Character.new(
      :name => nil,
      :marvel_id => 4,
      :modified => "Modified-String-2",
      :image_path => "The another_comic cover URL",
      :description => "The another_comic description"
    )
    
    assert_not character.save
  end

  test "a character should not be saved without marvel_id" do
    character = Character.new(
      :name => "Spider-Man",
      :marvel_id => nil,
      :modified => "Modified-String-2",
      :image_path => "The another_comic cover URL",
      :description => "The another_comic description"
    )
    
    assert_not character.save
  end

  test "a character should not be saved when marvel_id is not a number" do
    character = Character.new(
      :name => "Spider-Man",
      :marvel_id => "Number 16",
      :modified => "ModifiedString",
      :image_path => "The another_comic cover URL",
      :description => "The another_comic description"
    )
    
    assert_not character.save
  end

  test "a character is ok to be saved" do
    skip("Should be working, but for some reason elasticsearch is breaking it.")
    
    character = Character.new(
      :name => "Black Panther",
      :marvel_id => 10,
      :modified => "ModifiedString",
      :image_path => "The Black Panther comic cover URL",
      :description => "The Black Panther comic description"
    )
    
    assert character.save
  end
end