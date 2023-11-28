require "test_helper"

class ProcessControllerTest < ActionDispatch::IntegrationTest
  test "should get run" do
    get process_run_url
    assert_response :success
  end
end
