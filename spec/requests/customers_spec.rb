require 'spec_helper'

describe "Customers" do
  
 
  describe "Customers can view their order history", :js => false do
    it "does not allow a customer to place an order without specifying their name", :js => false do
      pop_prods
      visit products_path
      all(:link, "Add to Cart")[1].click
      click_button("Place Order")
      click_button("Create")
      page.should have_content("Customer was Not saved. Please make sure all fields are filled in.")
    end

  	it "lists a customer's previous orders", :js => false do
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
      page.should have_content("$6.00")
      page.should have_content("$4.00")
  		page.should have_no_content("Product 1a")
  		     
  	end

    it "displays a message if the customer has no previous orders", :js => false do
      #click_link("Order History") #SHouldn't need to worry about this because link isn't displayed if there aren't any previous orders
      pop_prods
      visit products_path
      all(:link, "Add to Cart")[1].click
      visit new_customer_path
      create_new_customer
      visit customer_orders_path
      page.should have_content("You have no previous orders.")
    end
  	
  end
end
