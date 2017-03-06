class HomeController < ApplicationController
  def index
  end

  def home
    @query = params[:query]
    @items_to_reorder = Item.search(@query)
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