require 'spec_helper'

describe "ShoppingCarts" do
  describe "customers view their shopping cart" do
    it "displays a message when there aren't any productys in it", :js => false do
      visit shopping_cart_path(1)
      page.should have_content("There currently aren't any items in your cart.")
    end
    it "displays the total retail price of all the items in it", :js => false do
      pop_prods
      visit products_path
      all(:link, "Add to Cart")[0].click
      click_link("Products")
      all(:link, "Add to Cart")[3].click
      page.should have_content("$3.00") # $1 + $2
      click_link("Products")
      all(:link, "Add to Cart")[6].click
      page.should have_content("$6.00") # $1 + $2 + $3
    end
  end

  describe "Customers empty a shopping cart" do
  	it "drops any products that are in it", :js => false do
  		pop_prods
  		visit products_path
  		all(:link, "Add to Cart")[0].click
  		visit products_path
  		all(:link, "Add to Cart")[4].click
  		#customer = Customer.get_or_create(nil) 
  		# shopping_cart = customer.create_shopping_cart
  		# shopping_cart.add_product(Product.find_by_name("Product 1a"))
  		# shopping_cart.add_product(Product.find_by_name("Product 2b"))
  		visit shopping_cart_path(1)
  		page.should have_content("Product 1a")
  		page.should have_content("Product 2b")
  		page.should have_no_content("Product 3c")
  		click_link("Empty Shopping Cart")
  		page.should have_content("Product 3") #should have been redirected to products page
  		visit(shopping_cart_path(1))
  		page.should have_no_content("Product 1a")
  		page.should have_no_content("Product 2b") 
  	end 
  end       

  describe "Customers checkout" do
  	it "Creates an order which references all of the products currently in the cart", :js => false do
  		pop_prods
  		visit products_path
  		first(:link, "Add to Cart").click
  		click_button("Place Order") 
  		create_new_customer
  		# page.should have_content("Congratulations your customer profile was successfully created")
  		# click_link "View Shopping Cart"
  		# click_button("Place Order")
  		page.should have_content("Your order has been submitted")

  	end
  end


end
