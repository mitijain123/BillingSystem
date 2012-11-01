require 'simplecov'
SimpleCov.start
require './test/test_helper'

class BillingTest < Test::Unit::TestCase
  def test_billing_for_2_year_customer
    User.expects(:gets).returns('1')
    billing = Billing::Billing.new.calculate_billing_price
    assert_equal Customer, billing.user.class
    assert_equal 5, billing.user.percentage_discount
    assert_equal 800, billing.total_price
    assert_equal 75, billing.discount.total_net_discount_price
    assert_equal 35, billing.discount.percentage_discounted_price
    assert_equal 40, billing.discount.every_hundred_discount_price
    assert_equal 725, billing.net_payable_price
  end

  def test_billing_for_affiliate_user
    User.expects(:gets).returns('2')
    billing = Billing::Billing.new.calculate_billing_price
    assert_equal Affiliate, billing.user.class
    assert_equal 10, billing.user.percentage_discount
    assert_equal 800, billing.total_price
    assert_equal 110, billing.discount.total_net_discount_price
    assert_equal 70, billing.discount.percentage_discounted_price
    assert_equal 40, billing.discount.every_hundred_discount_price
    assert_equal 690, billing.net_payable_price
  end

  def test_billing_for_employee
    User.expects(:gets).returns('3')
    billing = Billing::Billing.new.calculate_billing_price
    assert_equal Employee, billing.user.class
    assert_equal 30, billing.user.percentage_discount
    assert_equal 800, billing.total_price
    assert_equal 250, billing.discount.total_net_discount_price
    assert_equal 210, billing.discount.percentage_discounted_price
    assert_equal 40, billing.discount.every_hundred_discount_price
    assert_equal 550, billing.net_payable_price
  end

  def test_billing_for_regular_user
    User.expects(:gets).returns('4')
    billing = Billing::Billing.new.calculate_billing_price
    assert_equal User, billing.user.class
    assert_equal 0, billing.user.percentage_discount
    assert_equal 800, billing.total_price
    assert_equal 40, billing.discount.total_net_discount_price
    assert_equal 0, billing.discount.percentage_discounted_price
    assert_equal 40, billing.discount.every_hundred_discount_price
    assert_equal 760, billing.net_payable_price
  end

  def test_invalid_user
    User.expects(:gets).returns('5')
    assert_raise RuntimeError do
      Billing::Billing.new.calculate_billing_price
    end
  end

end