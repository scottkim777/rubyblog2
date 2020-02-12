require 'test_helper'


class CategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @cat = Category.create(name: "religion")
  end
  test "should get categories index" do
    get categories_url   # instead of path, we use url
    assert_response :success
  end

  test "should get new" do
    #get new_category_path
  end

  test "should get show " do
    get categories_path(@cat)
    assert_response :success
  end

end
