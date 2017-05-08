class OrdersController < ApplicationController
	include ChessStoreHelpers
	def index
		 @orders = Order.chronological.to_a
	end

	def show
		@order = Order.find(params[:id])
	end

	def new
		@order = Order.new
		@user = current_user
	    @cartItems = get_list_of_items_in_cart
	    @subtotal = calculate_cart_items_cost
	    @shipping = calculate_cart_shipping
	end	

	def create
			@subtotal = calculate_cart_items_cost
		    @shipping = calculate_cart_shipping
	    	@order = Order.new(order_params)
	    	@order.date = Date.today
	    	@order.grand_total = @subtotal + @shipping
	    	@order.user = current_user
	    	if @order.grand_total == 0
	    		 redirect_to cart_path, notice: "You don't have anything in your cart"
	    		return
	    	end

	    	unless @order.expiration_year.nil?
	    		@order.expiration_year = @order.expiration_year.to_f
	    	end
	    	unless @order.expiration_month.nil?
	    		@order.expiration_month = @order.expiration_month.to_f
	    	end
	     begin
		    if @order.save 
		      @order.pay
		      # save to cart
		      save_each_item_in_cart(@order)
		      clear_cart
		      redirect_to home_path, notice: "Checkout Complete."

		    else
		       @order.delete
		       render action: 'new'
		    end
    	 rescue Exception
    		 render action: 'new'
    	 end
  end


	private
	def order_params
    	params.require(:order).permit(:credit_card_number, :school_id, :expiration_year, :expiration_month)
  	end
end
