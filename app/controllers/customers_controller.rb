class CustomersController < ApplicationController
  def orders
  	
  end 

  def new
  	@customer = Customer.new #@shopping_cart.create_customer
  end

  def create
      @customer = Customer.new(params[:customer])
      customer_token = SecureRandom.uuid
   	  @customer.customer_token = customer_token

	  if @customer.save
	  	@shopping_cart.customer = @customer
	  	@shopping_cart.save
	    cookies[:customer_token] = customer_token
      if params[:from_order] == "true"
        redir_to = place_order_path #TODO: Make this redirect directly to the order creation???
      else
        redir_to = products_path
      end
	    redirect_to redir_to, notice: 'Congratulations your customer profile was successfully created.'
	  else
	    render action: "new"
	  end
  end

end
