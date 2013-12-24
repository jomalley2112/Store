require 'spec_helper'

feature "Products", :js => false do
  
  describe "Customers can browse the products by category" do
  	it "displays the current products" do
  		#product_category = ProductCategory.create :name => "Cat 1"
  		#product = product_category.products.create :name => "product 1", :description => "Some Description.", :wholesale_cost => 100, :retail_price => 150
      product = FactoryGirl.create(:product)  
  		visit products_path
  		page.should have_content("Product 1")
    end 

    it "displays the products in the current category only" do
      cats = pop_prods
      
      #Go to Products page when passing in category 1
      visit list_by_category_path(:id => cats[0].id)
      page.should have_content("Category 1") 
      page.should have_content("Product 1a")
      page.should have_no_content("Product 2a")

      #Go to Products page when passing in category 3
      visit list_by_category_path(:id => cats[2].id)
      page.should have_no_content("Category 1")
      page.should have_content("Category 3")
      page.should have_content("Product 3b")
      page.should have_no_content("Product 1a")
 
    end
 
  end 

  describe "Customers can search for products" do
    it "allows customer to enter a search term and view the products that match" do
      pop_prods
      visit products_path
      fill_in("txt_search", :with => "Product 1")
      #binding.pry
      click_button "Go"
      page.should have_content("Product 1")
      page.should have_no_content("Product 2")
    end 
  end
     
  describe "Customers can fill a shopping cart" do
    it "gets added to the user's shopping cart", :js => false do
      pop_prods
      visit products_path 
      first(:link, "Add to Cart").click
      page.should have_content("Your Shopping Cart")
      page.should have_content("Product 1")
      page.should have_no_content("Product 2")
    end
  end
  

  describe "Storekeepers" do
  	it "allows them to add new products", :js => false do
      visit new_product_path #this shoud be a link that's only available to Storekeepers
      fill_in("Name", :with => "Product 1")
      fill_in("Description", :with => "This product is...")
      fill_in("Retail Price", :with => "100")
      fill_in("Wholesale Cost", :with => "90")
      click_button("Save")
      #visit new_product_path
      fill_in("Name", :with => "Product 2")
      fill_in("Description", :with => "This product can be decribed...")
      fill_in("Retail Price", :with => "250")
      fill_in("Wholesale Cost", :with => "200")
      click_button("Save")
      visit products_path
      page.should have_content("Product 1")
      page.should have_content("This product is...")
      page.should have_content("Product 2")
      page.should have_content("This product can be decribed...")

  	end


  	it "allows them to update product information", :js => false do
      pop_prods
      visit edit_product_path(1)
      find_field('product[name]').value.should eq 'Product 1a'
      fill_in("Name", :with => "Edited name for Product 1a")
      fill_in("Description", :with => "Edited description...")
      fill_in("Retail Price", :with => "166")
      fill_in("Wholesale Cost", :with => "111")
      click_button("Save")
      page.should have_content("Product Updated!")
      find_field('product[name]').value.should eq 'Edited name for Product 1a'
  	end

  	it "allows them to remove products", :js => false do
      pop_prods
      visit admin_products_path
      page.should have_content("Product 1b")
      all(:link, "Delete")[1].click
      sleep 1
      page.should have_no_content("Product 1b")
      sleep 1
      page.should have_content("Product 3a")
      all(:link, "Delete")[5].click
      sleep 1
      page.should have_no_content("Product 3a")
  	end
  end
   
  
end
