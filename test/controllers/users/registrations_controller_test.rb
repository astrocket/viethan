require 'test_helper'

class Users::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get after_sign_up_path_for" do
    get users_registrations_after_sign_up_path_for_url
    assert_response :success
  end

end
