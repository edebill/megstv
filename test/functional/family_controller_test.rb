require 'test_helper'

class FamilyControllerTest < ActionController::TestCase
  self.use_transactional_fixtures = true

  setup do
    User.destroy_all
    @user   = Factory(:parent_user)

    @family = @user.family
    @new_user = Factory.build(:child_user)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:family_members)
  end


  test "should get index ( no family )" do
    @user.family = nil
    @user.save
    @family.destroy

    get :index
    assert_response :success
    assert_not_nil assigns(:family_members)
  end

  test "should create User" do
    assert_difference('User.count') do
      post :add_member, :user => @new_user.attributes.merge( { :password => "password",
                                                               :password_confirmation => "password" })
    end

    assert_redirected_to "http://test.host/family"
  end

end
