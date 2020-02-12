require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test for our category model

  # setup runs before all test
  def setup
    # this will run in test database, will automaticlaly clean and recreate
    @category = Category.new(name: "religion")

  end

  # test <testName> do
  test "category should be valid" do
    assert @category.valid?
  end

  test "category name should be present" do
    @category.name = " "
    assert_not @category.valid?
  end

  test "name should be unique" do
    @category.save  # save to the test database
    cat2 = Category.new(name: "religion")
    assert_not cat2.valid?   # should not be able to create duplicate
  end

  test "name sould not be too long" do
    @category.name = "a" * 26
    assert_not @category.valid?
  end
end
