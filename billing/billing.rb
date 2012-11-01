module Billing
  class Billing
    attr_accessor :billing_items, :user, :total_price, :net_payable_price, :discount

    #intialize billing object
    def initialize
      self.billing_items = BillingItem.get_billing_items
      self.user = User.select_user_type.new
      self.total_price = 0
      self.discount = Discount.new
    end

    # Show the billing items to user and calculate the discount and print it at the end
    def calculate_billing_price
      show_items
      self.discount.get_discount(self)
      print_billing_details
      self
    end

    # Show the billing items to end user
    def show_items
      puts "-------------------------------------------------"
      puts "Category   |   Item    |      Price "
      puts "-------------------------------------------------"
      billing_items.each do |billing_item_category, billing_items_with_price|
        billing_items_with_price.each do |billing_item, price|
          puts "#{billing_item_category} |  #{billing_item}  |  $ #{price}"
        end
      end
      puts "-------------------------------------------------"
    end


    # Show the final bill after discount to the end user
    def print_billing_details
      puts "--------------Final Bill-------------------------"
      puts "User type: #{self.user.class}"
      puts "-------------------------------------------------"
      puts "Category   |   Item    |      Price "
      puts "-------------------------------------------------"
      billing_items.each do |billing_item_category, billing_items_with_price|
        billing_items_with_price.each do |billing_item, price|
          puts "#{billing_item_category} |  #{billing_item}  |  $ #{price}"
        end
      end
      puts "-------------------------------------------------"
      puts "Total payable amount: $ #{total_price}"
      puts "Total percentage discount: $ #{discount.percentage_discounted_price}"
      puts "Total every hundred discount: $ #{discount.every_hundred_discount_price}"
      puts "Total Saving: $ #{discount.total_net_discount_price}"
      puts "Total net price after discount: $ #{net_payable_price}"
    end


  end
end