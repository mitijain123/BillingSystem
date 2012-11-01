class User

  attr_accessor :percentage_discount

  # initialize the user object with percentage discount
  def initialize
    self.percentage_discount = 0
  end

  # Select the Proper User type depending on the input provided
  def self.select_user_type
    puts "Select user type for net price?"

    User.user_types.each do |key, user_type|
      puts "#{key}. #{user_type}"
    end
    selected_user_type = gets.chomp
    user_type = User.user_types[selected_user_type.to_i]

    raise "Not a valid user!" if user_type.nil?

    user_type

  end

  private

  # Assumed Static user types to show to the end user for selection
  def self.user_types
    {1 => Customer, 2 => Affiliate, 3 => Employee, 4 => User}
  end

end