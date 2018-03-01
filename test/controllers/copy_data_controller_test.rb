require 'test_helper'

class CopyDataControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get copy_data_index_url
    assert_response :success
  end

end
