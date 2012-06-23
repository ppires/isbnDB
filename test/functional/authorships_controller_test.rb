require 'test_helper'

class AuthorshipsControllerTest < ActionController::TestCase
  setup do
    @authorship = authorships(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:authorships)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create authorship" do
    assert_difference('Authorship.count') do
      post :create, authorship: @authorship.attributes
    end

    assert_redirected_to authorship_path(assigns(:authorship))
  end

  test "should show authorship" do
    get :show, id: @authorship.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @authorship.to_param
    assert_response :success
  end

  test "should update authorship" do
    put :update, id: @authorship.to_param, authorship: @authorship.attributes
    assert_redirected_to authorship_path(assigns(:authorship))
  end

  test "should destroy authorship" do
    assert_difference('Authorship.count', -1) do
      delete :destroy, id: @authorship.to_param
    end

    assert_redirected_to authorships_path
  end
end
