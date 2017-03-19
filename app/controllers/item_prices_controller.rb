class ItemPricesController < ApplicationController

  # A callback to set up an @pet object to work with 
  before_action :set_itemPrice, only: [:show, :edit, :update, :destroy]

  
  def index
    # get data on all itemPrices and paginate the output to 10 per page
    @active_items = ItemPrice.current.chronological
  end

  def show
      @show_price = ItemPrice.for_item(params[:item_id]).chronological
  end

  def new
    @itemPrice = ItemPrice.new
  end

  def edit
  end

  def create

    @itemPrice = ItemPrice.new(itemPrice_params)
    @itemPrice.start_date = Date.current.to_date
    if @itemPrice.save
      @item = @itemPrice.item
      redirect_to @item, notice: "Changed the price of #{@item.name}."
    else
      render action: 'new'
    end
  end

  def update
    if @itemPrice.update_attributes(itemPrice_params)
      redirect_to @item, notice: "Changed the price of #{@item.name}."
    else
      render action: 'edit'
    end
  end

  def destroy
    @itemPrice.destroy
    redirect_to itemPrices_url, notice: "Removed #{@itemPrice.id} from the PATS system."
  end

  private
  # Use callbacks to share common setup or constraints between actions.
    def set_itemPrice
      @itemPrice = ItemPrice.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def itemPrice_params
      params.require(:item_price).permit(:item_id, :price, :start_date, :end_date)
    end


end
