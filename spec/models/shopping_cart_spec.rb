require 'spec_helper'

describe ShoppingCart do
  
  it "adds products" do
  	pop_prods
  	cart = FactoryGirl.create(:shopping_cart)
  	cart.add_product(Product.find_by_name("Product 1b"))
  	cart.add_product(Product.find_by_name("Product 2b"))
  	cart.add_product(Product.find_by_name("Product 3a"))
  	cart.cart_items.size.should eq(3)
  end 

  it "processes orders" do
  	pop_prods
  	#cart = FactoryGirl.create(:shopping_cart)
  	#binding.pry
  	cart = FactoryGirl.create(:customer).create_shopping_cart
  	cart.add_product(Product.find_by_name("Product 1b"))
  	cart.add_product(Product.find_by_name("Product 2b"))
  	cart.add_product(Product.find_by_name("Product 3a"))
  	order = cart.process_cart_items
  	order.order_items.size.should eq(3)
  	cart.cart_items.size.should eq(0)
  end

end
