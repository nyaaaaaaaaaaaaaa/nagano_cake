class Admin::HomesController < ApplicationController
   def top
    ##@customers = current_customer
    ##@item = Item.find(params[:id])
    ##@items = Item.all
    ##@genre = Genre.find(params[:id])
    ##@cart_items = Cart_items.find(params[:id])
    @orders = Order.page(params[:page]).per(10)
   end
end
