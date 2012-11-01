require './test_helper'
class UserTest < Test::Unit::TestCase
  def test_initialize_user
    user = User.new
    assert_equal 0, user.percentage_discount
  end

  def test_user_types
    user_hash = User.user_types
    assert_equal Customer, user_hash[1]
    assert_equal Affiliate, user_hash[2]
    assert_equal Employee, user_hash[3]
    assert_equal User, user_hash[4]
  end

  def test_select_user_type
    User.expects(:gets).returns('1')
    assert_equal Customer, User.select_user_type
    User.expects(:gets).returns('2')
    assert_equal Affiliate, User.select_user_type
    User.expects(:gets).returns('3')
    assert_equal Employee, User.select_user_type
    User.expects(:gets).returns('4')
    assert_equal User, User.select_user_type
    User.expects(:gets).returns('5')
    assert_raise RuntimeError do
      User.select_user_type
    end


  end
end