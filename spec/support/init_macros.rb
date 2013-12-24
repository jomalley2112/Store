module InitMacros

	def pop_prods
	  cats = [] #to keep track of the ids generated
      (1..3).each do |n|
        cat = FactoryGirl.create(:product_category, :name => "Category #{n.to_s}")
        cats << cat
        ("a".."c").each do |l|
          cat.products.create(:name => "Product #{n.to_s+''+l}", :description => "Some Description.", :wholesale_cost => 100, :retail_price => 150)
        end 
      end
      return cats	
	end
  def pop_cart
    pop_prods
    customer = FactoryGirl.create(:customer)
    #customer = Customer.new
    
    #shopping_cart = customer.create_shopping_cart
    shopping_cart = FactoryGirl.create(:shopping_cart)
    
    shopping_cart.customer = customer
    shopping_cart.save

    shopping_cart.add_product(Product.find_by_name("Product 1a"))
    shopping_cart.add_product(Product.find_by_name("Product 2b"))
    #binding.pry
    shopping_cart.process_cart_items()
    shopping_cart.add_product(Product.find_by_name("Product 1c"))
    shopping_cart.add_product(Product.find_by_name("Product 3b"))
    shopping_cart.process_cart_items()

  end

  def create_new_customer
    fill_in("First Name", :with => "Jackie")
    fill_in("Last Name", :with => "Anderson")
    fill_in("Address", :with => "111 First Street New York, NY 12345")
    click_button("Create")
  end

  # def pop_orders
  #   pop_cart
  #   #binding.pry
  #   #shopping_cart.process_cart_items
  # end
end	