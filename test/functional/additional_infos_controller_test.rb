require 'test_helper'

class AdditionalInfosControllerTest < ActionController::TestCase
  setup do
    @additional_info = additional_infos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:additional_infos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create additional_info" do
    assert_difference('AdditionalInfo.count') do
      post :create, additional_info: @additional_info.attributes
    end

    assert_redirected_to additional_info_path(assigns(:additional_info))
  end

  test "should show additional_info" do
    get :show, id: @additional_info.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @additional_info.to_param
    assert_response :success
  end

  test "should update additional_info" do
    put :update, id: @additional_info.to_param, additional_info: @additional_info.attributes
    assert_redirected_to additional_info_path(assigns(:additional_info))
  end

  test "should destroy additional_info" do
    assert_difference('AdditionalInfo.count', -1) do
      delete :destroy, id: @additional_info.to_param
    end

    assert_redirected_to additional_infos_path
  end
end
