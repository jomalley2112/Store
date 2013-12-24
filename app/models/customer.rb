class Customer < ActiveRecord::Base
	has_one :shopping_cart
	has_many :orders
	attr_accessible :address, :first_name, :last_name, :customer_token

 	# def self.get_or_create(cookie_token = nil)
 	# 	binding.pry
	# 	if customer_token = cookie_token
	# 	  @customer = Customer.find_by_customer_token(customer_token)
	# 	else
	# 	  #Should we have the name and address coming in here?
	# 	  @customer = Customer.create(:customer_token => SecureRandom.uuid)
	# 	  @customer.create_shopping_cart
	# 	end
	# 	return @customer
	# end


end
