class Customer < ActiveRecord::Base
	has_one :shopping_cart
	has_many :orders
	attr_accessible :address, :first_name, :last_name, :customer_token
	#validates_presence_of :first_name, :last_name, :customer_token

	def filled_in?
		!self.first_name.blank? && !self.last_name.blank?
	end

end
