class Discount
  attr_accessor  :total_net_discount_price, :percentage_discounted_price, :every_hundred_discount_price

  # initialize the discount object with the type of discounts and total discount got
  def initialize
    self.total_net_discount_price = 0
    self.percentage_discounted_price = 0
    self.every_hundred_discount_price = 0
  end

  # Making use of the billing object with the total price and billing items in billing,
  # It will calculate the discount to be applied.
  def get_discount(billing)
    percentage_discountable_total_price = 0
    billing.billing_items.each do |billing_category, billing_item_with_price|
      non_discount_category = Discount.non_discount_category.include?(billing_category)
      billing_item_with_price.each do |billing_item, price|
        percentage_discountable_total_price += price unless non_discount_category
        billing.total_price += price
      end
    end
    get_percentage_discount_price(percentage_discountable_total_price, billing)
    self.total_net_discount_price += self.percentage_discounted_price
    self.total_net_discount_price += get_every_hundred_discount(billing.total_price)
    billing.net_payable_price = (billing.total_price - total_net_discount_price)
  end

  private

  # get the discount percentage depending on the user.
  def get_percentage_discount_price(percentage_discountable_total_price, billing)
    self.percentage_discounted_price = percentage_discountable_total_price * billing.user.percentage_discount / 100
  end

  # get the discount percentage depending on the user.
  def get_every_hundred_discount(total_price)
    self.every_hundred_discount_price = (total_price - (total_price % 100))/100 * 5
  end

  # Categories which are not included for percentage discount.
  def self.non_discount_category
    ["groceries"]
  end
end