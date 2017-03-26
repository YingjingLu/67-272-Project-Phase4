require 'test_helper'

class SchoolsControllerTest < ActionController::TestCase
  setup do
    @school = schools(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:schools)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create school" do
    assert_difference('School.count') do
      post :create, school: { active: @school.active, city: @school.city, max_grade: @school.max_grade, min_grade: @school.min_grade, name: @school.name, state: @school.state, street_1: @school.street_1, street_2: @school.street_2, zip: @school.zip }
    end

    assert_redirected_to school_path(assigns(:school))
  end

  test "should show school" do
    get :show, id: @school
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @school
    assert_response :success
  end

  test "should update school" do
    patch :update, id: @school, school: { active: @school.active, city: @school.city, max_grade: @school.max_grade, min_grade: @school.min_grade, name: @school.name, state: @school.state, street_1: @school.street_1, street_2: @school.street_2, zip: @school.zip }
    assert_redirected_to school_path(assigns(:school))
  end

  test "should destroy school" do
    assert_difference('School.count', -1) do
      delete :destroy, id: @school
    end

    assert_redirected_to schools_path
  end
end
