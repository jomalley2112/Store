class Customer < ActiveRecord::Base
	has_one :shopping_cart
	has_many :orders
	attr_accessible :address, :first_name, :last_name, :customer_token

end
