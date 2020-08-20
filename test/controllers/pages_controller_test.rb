require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get pages_home_url
    assert_response :success
  end
   include Devise::Test::IntegrationHelpers

  def setup
    sign_in FactoryBot.create(:user)
  end

end
