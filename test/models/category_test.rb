require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  #this method runs before all methods
  def setup
    puts 'CATEGORIES'
    @category = Category.new(name: 'sports')
  end

  #test 1
  test "category should be valid" do
    puts "Try to create a new instance."
    assert @category.valid?
  end

  #test 2
  test "name should present" do
    puts "Test for non-nil names"
    @category.name = ""
    assert_not @category.valid?
  end

  #test 3
  test "name should be unique" do
    puts "Test for name to be unique"
    @category.save
    @category = Category.new(name: "sports")
    assert_not @category.valid?
  end

  #test 4
  test "name should not be too long" do
    puts "test for name to be not to long"
    @category = Category.new
    @category.name = "123456789101112131415"
    assert_not @category.valid?
  end
end