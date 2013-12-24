require 'spec_helper'

describe ProductCategory do
  #pending "add some examples to (or delete) #{__FILE__}"
  it "has a name" do
  	product_category = FactoryGirl.create(:product_category) #ProductCategory.new
  	expect(product_category.attributes).to include("name")
  end
  
  # it "has products" do
  # 	product_category = FactoryGirl.create(:product_category) #ProductCategory.new
  # 	expect(product_category.attributes).to include("products")
  # end


end
