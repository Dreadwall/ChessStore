class CartController < ApplicationController
   include ChessStoreHelpers
   def show
     @user = current_user
     @cartItems = get_list_of_items_in_cart
    
  end




  def add_item
  	unless params[:quantity].nil?
  		begin
  			quantity = params[:quantity].to_s.to_f
  			item_id = params[:item_id].to_s
  			if(quantity > 0)
	  			add_item_to_cart(item_id, quantity)
	  			flash[:notice] = "Item added to cart"
	  		end
  		rescue Exception
  			flash[:error] = "An error occured adding to cart."
  		end
  	end
  end


  def edit_quantity
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
