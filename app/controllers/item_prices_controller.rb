class ItemPricesController < ApplicationController
  # Using respond_to method so we can have output in different formats besides HTML
  respond_to :html, :xml, :json

  # A callback to set up an @pet object to work with 
  before_action :set_itemPrice, only: [:show, :edit, :update, :destroy]

  
  def index
    # get data on all itemPrices and paginate the output to 10 per page
    @itemPrices = ItemPrice.chronological.paginate(page: params[:page]).per_page(10)
    respond_with @itemPrices
  end

  def show
  end

  def new
    @itemPrice = ItemPrice.new
  end

  def edit
  end

  def create
    @itemPrice = ItemPrice.new(itemPrice_params)
    if @itemPrice.save
      redirect_to @itemPrice, notice: "Successfully added #{@itemPrice.name} as a PATS itemPrice."
    else
      render action: 'new'
    end
  end

  def update
    if @itemPrice.update_attributes(itemPrice_params)
      redirect_to @itemPrice, notice: "Updated #{@itemPrice.name}'s information"
    else
      render action: 'edit'
    end
  end

  def destroy
    @itemPrice.destroy
    redirect_to itemPrices_url, notice: "Removed #{@itemPrice.name} from the PATS system"
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_itemPrice
    @itemPrice = ItemPrice.find(params[:id])
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def itemPrice_params
    params.require(:itemPrice).permit(:item_id, :price, :start_date, :end_date)
  end


end
