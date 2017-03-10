class PurchasesController < ApplicationController
    # A callback to set up an @purchase object to work with 
  before_action :set_purchase, only: [:show, :edit, :update, :destroy]

  def index
    # get data on all vacines offered by PATS, 10 per page
    @purchases = Purchase.chronological.paginate(page: params[:page]).per_page(10)
  end
  
  def show
  end
  
  def new
    @purchase = Purchase.new
  end
  
  def create
    @purchase = Purchase.new(purchase_param)
    @purchase.date = Date.current
    if @purchase.save
      flash[:notice] = "Successfully added to Purchases."
      redirect_to @purchase
    else
      render action: 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @purchase.update_attributes(purchase_param)
      flash[:notice] = "Successfully updated #{@purchase.name} for #{@purchase.animal.name}."
      redirect_to @purchase
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @purchase = Purchase.find(params[:id])
    @purchase.destroy
    flash[:notice] = "Successfully destroyed #{@purchase.name} for #{@purchase.animal.name}."
    redirect_to purchases_url
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_purchase
    @vaccince = Purchase.find(params[:id])
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def purchase_param
    params.require(:purchase).permit(:item_id, :quantity, :date)
  end
end
