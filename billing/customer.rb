class Customer < User

  # initialize the customer user with percentage discount
  def initialize
    self.percentage_discount = 5
  end

end