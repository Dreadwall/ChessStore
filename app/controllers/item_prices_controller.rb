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
     respond_to do |format|
    if @item_price.save
      @item = @item_price.item
      @price_history = @item.item_prices.idealsort.paginate(:page => params[:page]).per_page(10)
     
          format.html { redirect_to item_prices_path, notice: 'Item Price was successfully created.' }
          format.js
    else
        format.html { render action: 'new', notice: 'Item Price had an error.' }
        format.json { render json: @item_price.errors, status: :unprocessable_entity }
    end
    end
  end

  private
  def item_price_params
    params.require(:item_price).permit(:item_id, :price, :category)
  end
  
end