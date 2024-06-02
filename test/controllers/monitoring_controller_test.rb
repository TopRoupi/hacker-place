require "test_helper"

class MonitoringControllerTest < ActionDispatch::IntegrationTest
  test "should get scripts" do
    get monitoring_scripts_url
    assert_response :success
  end
end
