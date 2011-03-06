require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  self.use_transactional_fixtures = true

  test "should get :index" do
    get :index
    assert_response :success
  end

  test "should redirect signed in users" do
    Minute.destroy_all
    User.destroy_all
    @parent = Factory(:parent_user)
    @child = Factory(:child_user, :family => @parent.family)
    sign_in @parent

    get :index
    assert_redirected_to minutes_url
  end
end
