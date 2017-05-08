class OrderItemsController < ApplicationController

	def ship
		@order_item = OrderItem.find(params[:id])
		authorize! :ship, @order_item
		@order_item.shipped
			@unshippedorders = Order.not_shipped.chronological.paginate(:page => params[:page]).per_page(10)
			respond_to do |format|
	          format.js
	        end
	     
	end
end
