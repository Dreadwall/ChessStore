class CartController < ApplicationController
   include ChessStoreHelpers
   def show
   	create_cart
     @user = current_user
     @cartItems = get_list_of_items_in_cart
     @subtotal = calculate_cart_items_cost
     @shipping = calculate_cart_shipping
  end




  def add_item
  	create_cart
  	unless params[:quantity].nil? || params[:item_id].nil?
  		begin
  			quantity = params[:quantity].to_s.to_f
  			item_id = params[:item_id].to_s
  			if(quantity > 0)
	  			myadd_item_to_cart(item_id, quantity)
	  		end
  		rescue Exception
  		end
  	end
     @user = current_user
     @cartItems = get_list_of_items_in_cart
     @subtotal = calculate_cart_items_cost
     @shipping = calculate_cart_shipping
  end



  def remove_item
    create_cart
    unless params[:item_id].nil?
      begin
        item_id = params[:item_id].to_s
        remove_item_from_cart(item_id)
        respond_to do |format|
          format.js
        end
      rescue Exception
      end
    end
     @user = current_user
     @cartItems = get_list_of_items_in_cart
     @subtotal = calculate_cart_items_cost
     @shipping = calculate_cart_shipping
  end


  def edit_quantity
  	create_cart
  	unless params[:quantity].nil?
  		begin
  			quantity = params[:quantity].to_s.to_f
  			item_id = params[:item_id].to_s
  			if(quantity < 0)
  				remove_item_from_cart(item_id, quantity)
  			else
  				add_item_to_cart(item_id, quantity)
  			end
  		rescue Exception
  			flash[:error] = "An error occured adding to cart."
  		end
  	end
  end

end
