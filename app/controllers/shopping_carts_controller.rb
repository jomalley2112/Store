class ShoppingCartsController < ApplicationController
  def show
  	@shopping_cart = get_or_create_cart
  	@cart_items = @shopping_cart.cart_items
  end
 
  def place_order
  	@shopping_cart = ShoppingCart.find_by_cart_token(session[:cart_token])
    redirect_to new_customer_path and return unless @shopping_cart.customer
  	@shopping_cart.process_cart_items
  	redirect_to @shopping_cart, :notice => "Your order has been submitted."
  end

  def clear_cart
  	@shopping_cart = ShoppingCart.find_by_cart_token(session[:cart_token])
  	@shopping_cart.cart_items = []
  	redirect_to products_path
  end
end
