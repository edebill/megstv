require 'test_helper'

class MinutesControllerTest < ActionController::TestCase
  self.use_transactional_fixtures = false
  setup do
    Minute.destroy_all
    User.destroy_all
    @parent = Factory(:parent_user)
    @child = Factory(:child_user, :family => @parent.family)
    @minute = Factory(:minute, :user => @child, :child => @child)
    sign_in :user, @parent

    @new_minute = Factory.build(:minute, :user_id => @parent.id,
                                :child_id => @child.id)
  end

  test "should get index (parent)" do
    get :index
    assert_response :success
    assert_not_nil assigns(:children)
  end


  test "should get index (child)" do
    sign_in @child
    get :index
    assert_response :success
    assert_not_nil assigns(:children)
  end

  test "redirect without family" do
    @parent.family = nil
    @parent.save
    get :index
    assert_redirected_to family_index_url
  end

  test "should create minute (parent)" do
    assert_difference('Minute.count') do
      post :create, :minute => @new_minute.attributes
    end

    assert_redirected_to minutes_url
  end


  test "should create minute (child)" do
    sign_in @child
    assert_difference('Minute.count') do
      post :create, :minute => @new_minute.attributes
    end

    assert_redirected_to minutes_url
  end


  test "should not create invalid minute" do
    @new_minute.amount = nil

    assert_no_difference('Minute.count') do
      post :create, :minute => @new_minute.attributes
    end

    assert_response :success
  end

  test "should show minute" do
    get :show, :id => @minute.to_param
    assert_response :success
  end

  test "should update minute" do
    MinutesController.any_instance.stubs(:current_user).returns(@minute.user)

    @minute.amount = -1
    put :update, :id => @minute.id.to_param, :minute => @minute.attributes
    assert_redirected_to minutes_url
    assert_equal -1, Minute.find(@minute.id).amount
  end


  test "should not update minute (invalid)" do
    @minute.amount = ""

    put :update, :id => @minute.id.to_param, :minute => @minute.attributes

    assert_equal 1, Minute.find(@minute.id).amount
  end


  test "should update minute (child)" do
    sign_out :user
    sign_in :user, @child
    
    @minute.amount = -1
    put :update, :id => @minute.id.to_param, :minute => @minute.attributes
    assert_redirected_to minutes_url
    assert_equal -1, Minute.find(@minute.id).amount
  end


  test "should not update minute (child, no permissions)" do
    @other_minute = Factory(:minute)
    @other_minute.amount = @other_minute.amount + 1
    sign_in @child
    User.any_instance.stubs(:can_edit?).returns(false)
    @other_minute.amount = -1
    put :update, :id => @other_minute.id.to_param, :minute => @other_minute.attributes
    assert_redirected_to minutes_url
    refute_equal Minute.find(@other_minute.id).amount, @other_minute.amount
  end

  test "should not update minute for other family" do
    @other_minute = Factory(:minute)
    @other_minute.amount = @other_minute.amount + 1
    
    put :update, :id => @other_minute.id.to_param, :minute => @other_minute.attributes
    assert_redirected_to minutes_url
    refute_equal Minute.find(@other_minute.id).amount, @other_minute.amount
  end

  test "should destroy minute" do
    assert_difference('Minute.count', -1) do
      delete :destroy, :id => @minute.to_param
    end

    assert_redirected_to minutes_path
  end

end
