class ProductCategory < ActiveRecord::Base
	has_many :products

	#accepts_nested_attributes_for :products
  	attr_accessible :name #, :description, :name, :product_category_id, :retail_price, :wholesale_cost
end
