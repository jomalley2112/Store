require 'spec_helper'

describe "Customers" do
  
 
  describe "Customers can view their order history", :js => false do
  	it "lists a customer's previous orders" do
  		pop_prods
      visit products_path
      all(:link, "Add to Cart")[1].click
      click_link("Products") 
      all(:link, "Add to Cart")[3].click
      click_link("Products")
      all(:link, "Add to Cart")[6].click
      click_button("Place Order")
      create_new_customer
      click_link("Products")
      #add some more products
      all(:link, "Add to Cart")[2].click
      click_link("Products")
      all(:link, "Add to Cart")[8].click
      click_button("Place Order")
      click_link("Order History")
      
  		page.should have_content("Product 1b")
  		page.should have_content("Product 2a")
      page.should have_content("Product 3a")
      page.should have_content("Product 1c")
      page.should have_content("Product 3c")
  		page.should have_no_content("Product 1a")
  		     
  	end

  	
  end
end
