require 'spec_helper'

feature "ProductCategories", :js => false do
  
  describe "Products belong to ProductCategories", :js => false do
  	it "displays a message when there aren't any product categories" do
  		visit(product_categories_path)
  		page.should have_content("Currently there aren't any product categories defined.")
  	end
  end
end