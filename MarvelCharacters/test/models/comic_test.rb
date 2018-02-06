require 'test_helper'

class ComicTest < ActiveSupport::TestCase
  self.use_transactional_tests = true

   test "a comic should not be saved when database already have a comic with a given marvel_id" do
      another_comic = Comic.new(
        :title => "Iron Man",
        :marvel_id => 4,
        :issue_number => 42,
        :modified => "Modified-String-2",
        :image_path => "The another_comic cover URL",
        :description => "The another_comic description"
      )

     assert_not_equal comics(:a_comic), another_comic
     assert_not_equal comics(:another_comic), another_comic
     assert_not another_comic.save
  end

  test "a comic should not be saved without title" do
    comic = Comic.new(
      :title => nil,
      :marvel_id => 4,
      :issue_number => 42,
      :modified => "Modified-String-2",
      :image_path => "The another_comic cover URL",
      :description => "The another_comic description"
    )

    assert_not comic.save
  end

  test "a comic should not be saved without marvel_id" do
    comic = Comic.new(
      :title => "Thor",
      :marvel_id => nil,
      :issue_number => 42,
      :modified => "Modified-String-2",
      :image_path => "The another_comic cover URL",
      :description => "The another_comic description"
    )

    assert_not comic.save
  end

  test "a comic should not be saved when marvel_id is not a number" do
    comic = Comic.new(
      :title => "Thor",
      :marvel_id => "Number 16",
      :issue_number => 42,
      :modified => "ModifiedString",
      :image_path => "The another_comic cover URL",
      :description => "The another_comic description"
    )

    assert_not comic.save
  end

  test "a comic can have more than one character" do
    comic = comics(:a_comic)

    occurences = Occurence.where(:comic_id => comic.id)
    
    assert_operator occurences.length, :>=, 1
  end

  test "a comic is ok to be saved" do
    skip("Should be working, but for some reason elasticsearch is breaking it.")
    
    comic = Comic.new(
      :title => "Black Panther",
      :marvel_id => 10,
      :issue_number => 1,
      :modified => "ModifiedString",
      :image_path => "The Black Panther comic cover URL",
      :description => "The Black Panther comic description"
    )

    assert comic.save
  end
end
