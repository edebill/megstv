require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  self.use_transactional_fixtures = true

  test "should get :index" do
    get :index
    assert_response :success
  end

end
