require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "logged user should get index" do
    sign_in_as(create(:player))
    get home_index_url
    assert_response :success
  end
end
