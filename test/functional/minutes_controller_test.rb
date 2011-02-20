require 'test_helper'

class MinutesControllerTest < ActionController::TestCase
  self.use_transactional_fixtures = false
  setup do
    Minute.destroy_all
    User.destroy_all
    @minute = Factory(:minute)
    @user   = @minute.user
    sign_in @user
    @child = @minute.child
    @child.family = @user.family
    @child.save

    @new_minute = Factory.build(:minute, :user_id => @user.id,
                                :child_id => @child.id)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:minutes)
  end

  test "should create minute" do
    assert_difference('Minute.count') do
      post :create, :minute => @new_minute.attributes
    end

    assert_redirected_to minutes_url
  end

  test "should show minute" do
    get :show, :id => @minute.to_param
    assert_response :success
  end

  test "should update minute" do
    @minute.amount = -1
    put :update, :id => @minute.id.to_param, :minute => @minute.attributes
    assert_redirected_to minutes_url
  end

  test "should destroy minute" do
    assert_difference('Minute.count', -1) do
      delete :destroy, :id => @minute.to_param
    end

    assert_redirected_to minutes_path
  end

end
