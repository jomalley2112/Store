class ShoppingCartsController < ApplicationController
  def show
    @shopping_cart = get_or_create_cart
    @cart_items = @shopping_cart.cart_items
    @can_place_order = true if @cart_items.length > 0
  end
 
  def place_order
    @shopping_cart = ShoppingCart.find_by_cart_token(session[:cart_token])
    redirect_to new_customer_path(:from_order => "true") and return unless @shopping_cart.customer && @shopping_cart.customer.filled_in?
    @order = @shopping_cart.process_cart_item   
    #TODO: Redirect to orders#show instead???
    #redirect_to @shopping_cart, :notice => "Your order has been submitted."
    redirect_to @order, :notice => "Your order has been submitted."
  end

  def clear_cart
    @shopping_cart = ShoppingCart.find_by_cart_token(session[:cart_token])
    @shopping_cart.cart_items = []
    redirect_to products_path, :notice => "Shopping Cart has been emptied!"
  end


end
