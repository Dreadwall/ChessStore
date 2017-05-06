class OrdersController < ApplicationController
	def index
		 @orders = Order.chronological.to_a
	end

	def show
		@order = Order.find(params[:id])
	end
end
