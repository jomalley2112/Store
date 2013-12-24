class OrdersController < ApplicationController
	def index
		@orders = Order.order("created_at").all
	end

	def show
		@order = Order.find(params[:id])
	end
end
