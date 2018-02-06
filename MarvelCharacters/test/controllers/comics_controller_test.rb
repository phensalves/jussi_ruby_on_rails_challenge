require 'test_helper'

class ComicsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get comics_url
    assert_response :success
  end

  test "should get show for all comics" do
    get comics_url
    assert_response :success

    comics = Comic.all
    for comic in comics do
      get comic_url(comic.id)
      assert_response :success
      get comics_url
      assert_response :success
    end
  end
end
