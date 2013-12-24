class CustomersController < ApplicationController
  def orders
  	#@customer = get_or_create_customer #Customer.find(params[:customer_id])
  	#binding.pry
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
	    redirect_to products_path, notice: 'Congratulations your customer profile was successfully created.'
	  else
	    render action: "new"
	  end
  end

end
