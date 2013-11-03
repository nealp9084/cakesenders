require 'test_helper'

class GoodiesControllerTest < ActionController::TestCase
  setup do
    @goodie = goodies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:goodies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create goodie" do
    assert_difference('Goodie.count') do
      post :create, goodie: { description: @goodie.description, name: @goodie.name, price: @goodie.price }
    end

    assert_redirected_to goody_path(assigns(:goodie))
  end

  test "should show goodie" do
    get :show, id: @goodie
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @goodie
    assert_response :success
  end

  test "should update goodie" do
    patch :update, id: @goodie, goodie: { description: @goodie.description, name: @goodie.name, price: @goodie.price }
    assert_redirected_to goody_path(assigns(:goodie))
  end

  test "should destroy goodie" do
    assert_difference('Goodie.count', -1) do
      delete :destroy, id: @goodie
    end

    assert_redirected_to goodies_path
  end
end
