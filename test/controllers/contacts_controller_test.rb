require "test_helper"

class ContactsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get contacts_new_url
    assert_response :success
  end

  test "should get confirm" do
    get contacts_confirm_url
    assert_response :success
  end

  test "should get thanks" do
    get contacts_thanks_url
    assert_response :success
  end
end
