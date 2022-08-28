class Public::CartItemsController < ApplicationController
  def index
    @items = Item.all
    @cart_items = CartItem.all
    @customer = customer_session.find(params[:id])
    @total = 0
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      flash[:notice] = "You have updated cart_item successfully."
      redirect_to cart_items_path
    else
      @customer = current_customer
      render :index
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    # @cart_items = CartItem.all
    # @cart_item = CartItem.find(params[:id])
    # @customer = customer_session.find(params[:id])
    # @customer = current_user
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end


  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if @cart_item.save!
      flash[:notice] = "You have created cart_item successfully."
      redirect_to cart_items_path
    else
      @cart_items = CartItem.all
      @cart_item_new = @cart_item
      @customer = current_customer
      render :index
    end
  end


  private


  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

  def correct_customer
    @cart_item = CartItem.find(params[:id])
    redirect_to(items_path) unless @customer == current_customer
  end

end
