require 'test_helper'

class SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get search result for a character and be able to access its page" do
    skip("Must have elasticsearch service running to pass this test")
    get search_url(:term => "Hulk")
    assert_response :success

    character_hulk = characters(:a_character)
    get character_url(character_hulk.id)
    assert_response :success
  end

  test "should be redirected to search error page" do
    skip("Must have elasticsearch service stopped to pass this test")
    get search_url(:term => "Hulk")
    assert_redirected_to controller: "search", action: "error"
  end
end
