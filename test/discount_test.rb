require './test_helper'
require 'ostruct'
class DiscountTest < Test::Unit::TestCase
  def setup
    BillingItem.stubs(:get_billing_items).
      returns({"groceries" => {"plates" => 100}, "cloths" => {"shirt" => 300, "pant" => 400}})
  end

  def test_discount_new
    discount = Discount.new
    assert_equal 0, discount.total_net_discount_price
    assert_equal 0, discount.percentage_discounted_price
    assert_equal 0, discount.every_hundred_discount_price
  end

  def test_get_discount_for_customer
    Billing.expects(:new).returns(OpenStruct.new(:billing_items => BillingItem.get_billing_items,
                                                 :user => Customer.new, :total_price => 0,
                                                 :discount => Discount.new))
    billing = Billing.new
    discount = Discount.new
    discount.get_discount(billing)
    assert_equal 725, billing.net_payable_price
    assert_equal 35, discount.percentage_discounted_price
    assert_equal 40, discount.every_hundred_discount_price
  end

  def test_get_discount_for_affiliate
    Billing.expects(:new).returns(OpenStruct.new(:billing_items => BillingItem.get_billing_items,
                                                 :user => Affiliate.new, :total_price => 0,
                                                 :discount => Discount.new))
    billing = Billing.new
    discount = Discount.new
    discount.get_discount(billing)
    assert_equal 690, billing.net_payable_price
    assert_equal 110, discount.total_net_discount_price
    assert_equal 70, discount.percentage_discounted_price
    assert_equal 40, discount.every_hundred_discount_price
  end

  def test_get_discount_for_employee
    Billing.expects(:new).returns(OpenStruct.new(:billing_items => BillingItem.get_billing_items,
                                                 :user => Employee.new, :total_price => 0,
                                                 :discount => Discount.new))
    billing = Billing.new
    discount = Discount.new
    discount.get_discount(billing)
    assert_equal 250, discount.total_net_discount_price
    assert_equal 210, discount.percentage_discounted_price
    assert_equal 40, discount.every_hundred_discount_price
    assert_equal 550, billing.net_payable_price
  end

  def test_get_discount_for_regular_user
    Billing.expects(:new).returns(OpenStruct.new(:billing_items => BillingItem.get_billing_items,
                                                 :user => User.new, :total_price => 0,
                                                 :discount => Discount.new))
    billing = Billing.new
    discount = Discount.new
    discount.get_discount(billing)
    assert_equal 40, discount.total_net_discount_price
    assert_equal 0, discount.percentage_discounted_price
    assert_equal 40, discount.every_hundred_discount_price
    assert_equal 760, billing.net_payable_price
  end
end