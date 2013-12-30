require 'spec_helper'

feature 'visiting the root' do
	it "directs to the products listing page" do
		visit "/"
		page.should have_content("Products")
	end

	it "does not display the Order History nav item when user is a Shopkeeper", :js => false do
		pop_prods
  		visit products_path
  		first(:link, "Add to Cart").click
  		click_button("Place Order") 
  		create_new_customer
  		click_link("Click here to switch Roles")
  		page.should have_no_content("Order History")
	end
end
