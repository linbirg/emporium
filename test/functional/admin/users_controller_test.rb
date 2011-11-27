require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @input_user = {
            :name => 'sam',
            :password => 'sam',
            :password_confirmation => 'sam'
    }
    @user = users(:one)

    @controller = Admin::UsersController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_template 'admin/users/new'
  end

  test "should create user" do
    assert_difference(User, :count) do
      post :create, :user => @input_user
    end

    assert_redirected_to admin_users_path
  end

  test "should show user" do
    get :show, :id => @user.to_param
    assert_response :success
    assert_template 'admin/users/show'
  end

  test "should get edit" do
    get :edit, :id => @user.to_param
    assert_response :success
    assert_template 'admin/users/edit'
  end

  test "should update user" do
    put :update, :id => @user.to_param, :user => @input_user
    assert_redirected_to admin_users_path
  end

  test "should destroy user" do
    assert_difference(User,:count, -1) do
      delete :destroy, :id => @user.to_param
    end

    assert_redirected_to admin_users_path
  end
end
