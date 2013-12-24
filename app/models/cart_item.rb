class CartItem < ActiveRecord::Base
  attr_accessible :product_id
  belongs_to :shopping_cart
  belongs_to :product

  
end
