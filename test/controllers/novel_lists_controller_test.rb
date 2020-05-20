require 'test_helper'

class NovelListsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @novel_list = novel_lists(:one)
  end

  test "should get index" do
    get novel_lists_url
    assert_response :success
  end

  test "should get new" do
    get new_novel_list_url
    assert_response :success
  end

  test "should create novel_list" do
    assert_difference('NovelList.count') do
      post novel_lists_url, params: { novel_list: { title: @novel_list.title } }
    end

    assert_redirected_to novel_list_url(NovelList.last)
  end

  test "should show novel_list" do
    get novel_list_url(@novel_list)
    assert_response :success
  end

  test "should get edit" do
    get edit_novel_list_url(@novel_list)
    assert_response :success
  end

  test "should update novel_list" do
    patch novel_list_url(@novel_list), params: { novel_list: { title: @novel_list.title } }
    assert_redirected_to novel_list_url(@novel_list)
  end

  test "should destroy novel_list" do
    assert_difference('NovelList.count', -1) do
      delete novel_list_url(@novel_list)
    end

    assert_redirected_to novel_lists_url
  end
end
