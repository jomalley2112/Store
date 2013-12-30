require 'spec_helper'

feature "Products", :js => false do
  
  describe "Customers can browse the products by category" do
  	it "shows message on index page when there aren't any products", :js => false do
      visit products_path
      page.should have_content("Currently there aren't any products in stock.")
    end

    it "displays a message when there aren't any products in a chosen category", :js => false do
      category = FactoryGirl.create(:product_category)
      visit list_by_category_path(category)
      page.should have_content("There aren't any products in the chosen category.")
    end

    it "displays the current products" do
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
      click_button "Go"
      page.should have_content("Product 1")
      page.should have_no_content("Product 2")
    end

    it "allows customers to clear the search box and have an unfiltered view of products", :js => true do
      pop_prods
      visit products_path
      fill_in("txt_search", :with => "Product 1")
      click_button "Go"
      page.should have_content("Product 1")
      page.should have_no_content("Product 2")
      find_field('txt_search').value.should eq("Product 1")
      click_button("Clear")
      find_field('txt_search').value.should eq("") 
      page.should have_content("Product 1")
      page.should have_content("Product 2")
      page.should have_content("Product 3")
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
      #visit new_product_path #this shoud be a link that's only available to Storekeepers
      category = FactoryGirl.create(:product_category)
      visit admin_products_path
      click_link("Add New")
      fill_in("Name", :with => "Product 1")
      fill_in("Description", :with => "This product is...")
      select(category.name, :from => "Category")
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

    it "displays a message when there aren't any categories to add a new product to", :js => false do
      visit admin_products_path
      click_link("Add New")
      page.should have_content("Please add at least one category before adding any products.")
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
