require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player = create(:player)
  end

  test "should get index" do
    sign_in_as @player

    get sessions_url
    assert_response :success
  end

  test "should get new" do
    get sign_in_url
    assert_response :success
  end

  test "should sign in" do
    post sign_in_url, params: {email: @player.email, password: "123456"}
    assert_redirected_to root_url

    get root_url
    assert_response :success
  end

  test "should not sign in with wrong credentials" do
    post sign_in_url, params: {email: @player.email, password: "1234567"}
    assert_redirected_to sign_in_url(email_hint: @player.email)
    assert_equal "That email or password is incorrect", flash[:alert]

    get root_url
    assert_redirected_to sign_in_url
  end

  test "should sign out" do
    sign_in_as @player

    delete session_url(@player.sessions.last)
    assert_redirected_to sessions_url

    follow_redirect!
    assert_redirected_to sign_in_url
  end
end
