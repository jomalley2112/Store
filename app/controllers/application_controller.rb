class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_shopping_cart
  before_filter :get_customer

  # def get_or_create_cart
  #   customer = get_or_create_customer
  #   shopping_cart = customer.shopping_cart || customer.create_shopping_cart
  # end


  def get_or_create_cart
    #may be first time here
    if cart_token = session[:cart_token]
      shopping_cart = ShoppingCart.find_by_cart_token(cart_token)
    else
      #TODO: Exception Handling here...there's a lot that can go wrong i.e. customer but no cart, Invalid or expired token in cookie or session
        cart_token = SecureRandom.uuid
        if customer_token = cookies[:customer_token]
          customer = Customer.find_by_customer_token #if they are already a customer add new cart for customer
          shopping_cart = customer.create_shopping_cart(:cart_token => cart_token)
        else
          #they are not a customer so just create a cart for them
          shopping_cart = ShoppingCart.create(:cart_token => cart_token)
        end
        session[:cart_token] = cart_token
    end
    return shopping_cart #prob not necc
  end

  def get_or_create_customer
    #binding.pry
    if token = cookies[:customer_token]
      @customer = Customer.find_by_customer_token(cookies[:customer_token])
    else
      redirect_to new_customer_path and return
    end

      #@customer = Customer.get_or_create(cookies[:customer_token])
      #customer_token = @customer.customer_token
      #cookies[:customer_token] = customer_token
    @customer
  end

  private
  def get_shopping_cart
    @shopping_cart = ShoppingCart.find_by_cart_token(session[:cart_token]) if session[:cart_token]
  end

  def get_customer
    @customer = Customer.find_by_customer_token(cookies[:customer_token]) if cookies[:customer_token]
  end


end
