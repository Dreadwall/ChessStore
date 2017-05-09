class PurchasesController < ApplicationController
  def index
    @purchases = Purchase.chronological.paginate(:page => params[:page]).per_page(10)
    authorize! :index, @purchases
  end

  def new
    @purchase = Purchase.new
    begin
      @item = Item.find(params[:item_id])
      if !@item.nil?
        @purchase.item = @item
      end
     rescue Exception
      end
    authorize! :new, @purchase
  end

  def create
    @purchase = Purchase.new(purchase_params)
    @purchase.date = Date.current
    
    if @purchase.save
       @item = @purchase.item
        respond_to do |format|
          format.html { redirect_to purchases_path, notice: 'Purchase was successfully created.'}
          format.js
        end
    else
      render action: 'new'
    end
  end

  private
  def purchase_params
    params.require(:purchase).permit(:item_id, :quantity)
  end
  
end