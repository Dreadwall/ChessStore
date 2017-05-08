class ItemPricesController < ApplicationController
  def index
    @active_items = Item.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    authorize! :index, @active_items
  end

  def new
    @item_price = ItemPrice.new
    authorize! :new, @item_price
     begin
      @item = Item.find(params[:this_item_id])
      if !@item.nil?
        @item_price.item = @item
      end
     rescue Exception
      end
  end

  def create
    @item_price = ItemPrice.new(item_price_params)
    @item_price.start_date = Date.current
    if @item_price.save
      @item = @item_price.item
      redirect_to item_path(@item), notice: "Changed the price of #{@item.name}."
    else
      render action: 'new'
    end
  end

  private
  def item_price_params
    params.require(:item_price).permit(:item_id, :price, :category)
  end
  
end