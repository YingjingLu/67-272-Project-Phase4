class HomeController < ApplicationController
  def index
  end

  def home
    @items_to_reorder = Item.need_reorder
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
  def search
    @query = params[:query]
    @purchases = Purchase.search(@query)
    @items = Item.search(@query)
    @item_prices = ItemPrice.search(@query)
  end
end