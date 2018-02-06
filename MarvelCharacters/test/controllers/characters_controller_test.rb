require 'test_helper'

class CharactersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get characters_url
    assert_response :success
  end

  test "should get show for all characters" do
    get characters_url
    assert_response :success

    characters = Character.all
    for character in characters do      
      get character_url(character.id)
      assert_response :success
      get characters_url
      assert_response :success
    end
  end
end