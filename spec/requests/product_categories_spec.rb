require 'spec_helper'

feature "ProductCategories", :js => false do
  describe "Storekeepers manage categories" do
  	it "creates a new one when a Storekeeper adds it" do
  		visit "/"
  		click_link("Click here to switch Roles")
  		click_link("Categories")
  		click_link("New Product Category")
  		fill_in("Name", :with => "Category 1")
  		click_button("Save")
  		page.should have_content("Category was created!")
  		page.should have_content("Category 1")
  	end

  	it "updates one", :js => false do
  		visit "/"
  		click_link("Click here to switch Roles")
  		click_link("Categories")
  		click_link("New Product Category")
  		fill_in("Name", :with => "Category 1")
  		click_button("Save")
  		#binding.pry
  		all(:link, "Edit")[0].click
  		fill_in("Name", :with => "Edited Category Name")
  		click_button("Save")
  		page.should have_content("Category was updated!")
  		page.should have_content("Edited Category Name")
  	end

  	it "Allows only Storekeepers to manage categories" do
  		visit "/"
  		click_link("Categories")
  		page.should have_no_content("New Product Category")
  		page.should have_no_content("Edit")
  		page.should have_no_content("Destroy")
  	end

  end
  describe "Products belong to ProductCategories", :js => false do
  	it "displays a message when there aren't any product categories" do
  		visit(product_categories_path)
  		page.should have_content("Currently there aren't any product categories defined.")
  	end
  end
end