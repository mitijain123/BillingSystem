require './billing/user.rb'
require './billing/affiliate.rb'
require './billing/customer.rb'
require './billing/employee.rb'
require "./billing/billing.rb"
require "./billing/billing_item.rb"
require "./billing/discount.rb"

module Billing

end

Billing::Billing.new.calculate_billing_price

