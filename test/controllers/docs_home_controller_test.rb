require 'test_helper'

class DocsHomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get docs_home_index_url
    assert_response :success
  end

end
