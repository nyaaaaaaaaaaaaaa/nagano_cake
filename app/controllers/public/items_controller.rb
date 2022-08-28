class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(8)
    @total = 0
  end

  def show
    @item = Item.find(params[:id])
    @items = Item.all
    @cart_item = CartItem.new
    ##@genre = Genre.find(params[:id])
  end


  private

end
