require 'test_helper'

class ChatBotControllerTest < ActionDispatch::IntegrationTest
  test "should get initiate" do
    get chat_bot_initiate_url
    assert_response :success
  end

end
