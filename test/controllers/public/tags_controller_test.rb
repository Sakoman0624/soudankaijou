require "test_helper"

class Public::TagsControllerTest < ActionDispatch::IntegrationTest
  test "should get guide" do
    get public_tags_guide_url
    assert_response :success
  end
end
