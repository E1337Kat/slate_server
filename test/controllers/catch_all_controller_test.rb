require 'test_helper'

class CatchAllControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get catch_all_index_url
    assert_response :success
  end

end
