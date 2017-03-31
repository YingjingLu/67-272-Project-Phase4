class ItemsController < ApplicationController
  # A callback to set up an @item object to work with 
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    # finding all the items in alphabetical order and return as an array
    @boards = Item.active.for_category("boards").paginate(:page => params[:page]).per_page(10)
    @pieces = Item.active.for_category("pieces").paginate(:page => params[:page]).per_page(10)
    @clocks = Item.active.for_category("clocks").paginate(:page => params[:page]).per_page(10)
    @supplies = Item.active.for_category("supplies").paginate(:page => params[:page]).per_page(10)
    @inactive_items = Item.inactive.paginate(:page => params[:page]).per_page(10)

  end

  def show
    # show price history
    @item = Item.find(params[:id])
    @price_history = ItemPrice.for_item(@item)
    @similar_items = Item.for_category(@item.category).active - [@item]
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
      redirect_to @item, notice: "Successfully created #{@item.name}." # go to show item page
    else
      # return to the 'new' form
      render action: 'new'
    end
  end

  def update
    if @item.update_attributes(item_params)
      redirect_to @item, notice: "Successfully updated #{@item.name}."
    else
      render action: 'edit'
    end
  end

  def destroy
    @item.destroy
    redirect_to items_url, notice: "Successfully removed #{@item.name} from the system."
  end

  def view_reorder_list
    @items = Item.need_reorder.alphabetical.to_a
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :description, :category, :color, :picture, :weight,
                                   :inventory_level, :reorder_level, :active)
    end
end