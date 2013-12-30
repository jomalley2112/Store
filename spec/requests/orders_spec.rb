require 'spec_helper'

describe "Orders" do
  describe "Storekeepers can view a list of customer orders" do
  	it "displays a list of orders that have been made", :js => false do
  		pop_cart
      visit "/"
      click_link("Click here to switch Roles")
  		click_link("All Orders")
      page.should have_content("Product 1a")
  		page.should have_content("Product 2b")
  		page.should have_content("Product 1c")
  		page.should have_content("Product 3b")
      page.should have_content("$2.40")
      page.should have_content("$3.00")
      page.should have_content("$3.20")
      page.should have_content("$4.00")
  	end
  	it "displays a particular order's details to Shopkeepers", :js => false do
  		pop_cart
      visit "/"
  		click_link("Click here to switch Roles")
      click_link("All Orders")
      click_link("Order 2")
  	  page.should have_content("JacobsLadder, John")
      page.should have_content("$1.00")
  		page.should have_content("$3.00")
  		page.should have_content("Product 1c")
  		page.should have_content("Product 3b")
      page.should have_content("$4.00")
  		page.should have_no_content("Product 1a")
  		page.should have_no_content("Product 2b")
    end
    it "displays a message when there aren't any orders yet", :js => false do
      visit orders_path
      page.should have_content("There aren't any orders.")
    end

  end

  describe "Customers see the details of the order they just submitted", :js => false do
    it "displays the order details but not the wholesale costs" do
      pop_prods
      visit products_path
      all(:link, "Add to Cart")[0].click
      visit products_path
      all(:link, "Add to Cart")[4].click
      click_link("Shopping Cart")
      click_button("Place Order")
      create_new_customer
      page.should have_content("Product")
      page.should have_content("Description")
      page.should have_content("Retail Price")
      page.should have_no_content("Wholesale Cost")
    end
  end
end
