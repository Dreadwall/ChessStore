class HomeController < ApplicationController
  def home
    @user = current_user
    @all_items = Item.all.active
    @items_to_reorder = Item.need_reorder.alphabetical.paginate(:page => params[:page]).per_page(10)
  	@unshippedorders = Order.not_shipped.chronological.paginate(:page => params[:page]).per_page(10)
  end

  def about
  end

  def contact
  end

  def privacy
  end

  
end