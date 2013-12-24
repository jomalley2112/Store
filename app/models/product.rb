class Product < ActiveRecord::Base
	belongs_to :products_category
	has_many :cart_items
  	attr_accessible :description, :name, :product_category_id, :retail_price, :wholesale_cost

end
