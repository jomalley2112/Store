class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_shopping_cart
  before_filter :get_customer
  before_filter :get_admin

  def get_or_create_cart
    if cart_token = session[:cart_token]
      shopping_cart = ShoppingCart.find_by_cart_token(cart_token)
    else
      #TODO: Exception Handling here...there's a lot that can go wrong i.e. customer but no cart, Invalid or expired token in cookie or session
        cart_token = SecureRandom.uuid
        #binding.pry
        if customer_token = cookies[:customer_token]
          if customer = Customer.find_by_customer_token(customer_token) #if they are already a customer add new cart for customer
          else
            customer = Customer.create :customer_token => cookies[:customer_token]
            #Rest of Customer info is left empty (name, address)
          end
          shopping_cart = customer.create_shopping_cart(:cart_token => cart_token)
        else
          #they are not a customer so just create a cart for them
          shopping_cart = ShoppingCart.create(:cart_token => cart_token)
        end
        session[:cart_token] = cart_token
    end
    return shopping_cart #prob not necc
  end

  private

  def get_shopping_cart
    @shopping_cart = ShoppingCart.find_by_cart_token(session[:cart_token]) if session[:cart_token]
  end

  def get_customer
    @customer = Customer.find_by_customer_token(cookies[:customer_token]) if cookies[:customer_token]
  end

  def get_admin
    @admin = true if session[:admin] == "true"
  end

end
