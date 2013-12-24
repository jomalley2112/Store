require 'spec_helper'

describe "Orders" do
  describe "Storekeepers can view a list of customer orders" do
  	it "displays a list of orders that have been made", :js => false do
  		pop_cart
  		visit orders_path
  		page.should have_content("Product 1a")
  		page.should have_content("Product 2b")
  		page.should have_content("Product 1c")
  		page.should have_content("Product 3b")
  	end
  	it "displays a particular order's details", :js => false do
  		pop_cart
  		visit orders_path
  		click_on("Order 2")
  		page.should have_content("JacobsLadder, John")
  		page.should have_content("100")
  		page.should have_content("150")
  		page.should have_content("Product 1c")
  		page.should have_content("Product 3b")
  		page.should have_no_content("Product 1a")
  		page.should have_no_content("Product 2b")
	end
  end
end
