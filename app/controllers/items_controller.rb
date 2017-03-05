class ItemsController < ApplicationController
  # A callback to set up an @item object to work with 
  before_action :set_item, only: [:show, :edit, :update, :destroy]

    def index
    # finding all the items in alphabetical order and return as an array
    @items = Item.alphabetical.to_a
  end

  def show
    # Ahow all the item prices related to that item
    @item_prices = ItemPrice.for_item(@item.id).paginate(page: params[:page]).per_page(10)
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      # if saved to database
      flash[:notice] = "Successfully created #{@item.name}."
      redirect_to @item # go to show item page
    else
      # return to the 'new' form
      render action: 'new'
    end
  end

  def update
    if @item.update_attributes(item_params)
      flash[:notice] = "Successfully updated #{@item.name}."
      redirect_to @item
    else
      render action: 'edit'
    end
  end

  def destroy
    @item.destroy
    flash[:notice] = "Successfully removed #{@item.name} from the PATS system."
    redirect_to items_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :description, :category, :color, :weight,
                                   :inventory_level, :reorder_level, :active)
    end
end