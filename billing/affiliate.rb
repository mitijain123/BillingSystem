class Affiliate < User

  # initialize the affiliate user with percentage discount
  def initialize
    self.percentage_discount = 10
  end
end