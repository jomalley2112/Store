class ShoppingCart < ActiveRecord::Base
  attr_accessible :cart_token
  has_many :cart_items, :dependent => :destroy
  belongs_to :customer
 
  def add_product(product)
  	self.cart_items.create(:product_id => product.id)
  end


  #At this point the shopping cart NEEDS to belong to a customer
  def process_cart_items()
  	order = self.customer.orders.create
  	self.cart_items.each do |item|
  		order.order_items.create :product_id => item.product_id
  	end
  	self.cart_items = [] #clear the cart
  	return order
  end
end
