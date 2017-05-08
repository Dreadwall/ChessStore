class OrdersController < ApplicationController
	include ChessStoreHelpers
	def index
		 @orders = Order.chronological.to_a
		 authorize! :index, @orders
	end

	def show
		@order = Order.find(params[:id])
		authorize! :show, @order
	end

	def cancel
		@order = Order.find(params[:id])
		authorize! :cancel, @order
		if @order.notshipped? && @order.destroy
			redirect_to user_path(current_user), notice: "Your entire order has been cancelled."
		else
			redirect_to order_path(@order), notice: "Sorry, one or more of the items have shipped already."
		end
	end

	def new
		@order = Order.new
		@user = current_user
	    @cartItems = get_list_of_items_in_cart
	    @subtotal = calculate_cart_items_cost
	    @shipping = calculate_cart_shipping
	    authorize! :new, @order
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
			  save_each_item_in_cart(@order)
		      @order.pay
		     
		      clear_cart
		      redirect_to order_path(@order), notice: "Checkout Complete. "

		    else
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
