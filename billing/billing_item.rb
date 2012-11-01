#!/usr/bin/env ruby1.9.1
class BillingItem

  # Assumed and static billing items
  def self.get_billing_items
    {"groceries" => {"plates" => 100}, "cloths" => {"shirt" => 300, "pant" => 400}}
  end

end