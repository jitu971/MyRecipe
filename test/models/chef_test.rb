require 'test_helper'
class ChefTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new(chefname: "john", email: "john@gmail.com")
  end

  test "Chef should be valid" do 
    assert @chef.valid?
  end

  test "Chef name should be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end

  test "chefname length not too long" do
    @chef.chefname = "a"*41
    assert_not @chef.valid?
  end

  test "chefname length not too short" do
    @chef.chefname = "aa"
    assert_not @chef.valid?
  end

  test "Email should be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end

  test "email length should be within bound" do
    @chef.email = "a" * 101 + "@example.com"
    assert_not @chef.valid?
  end

  test "email address should be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end

  test "Email accept valid address" do
    valid_address = %w[user@eee.com R_TDD-DS@eee.hello.org user@example.com first.last@eem.au laura+joe@monk.cm]
    valid_address.each do |va|  
      @chef.email = va
      assert @chef.valid?, '#{va.inspect} should be valid'
    end
  end

  test "Email reject Invalid Address" do
    invalid_address = %w[user@example, user_at_eee.org,user.name@example,eee@i_am_.com.foo@ee+arr.com]
    invalid_address.each do |ia|
      @chef.email = ia
      assert_not @chef.valid?, '#{ia.inspect} should be invalid'
    end
  end

end