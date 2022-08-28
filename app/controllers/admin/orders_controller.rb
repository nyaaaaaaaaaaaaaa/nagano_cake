class Admin::OrdersController < ApplicationController
  def show
    @orders = Order.all
    @order = Order.find(params[:id])
    @order.shipping_cost = 800
    @cart_items = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    if @order.update(order_params)
      flash[:notice] = "You have updated order successfully."
      if @order.status == "confirm"
        @order_details.each do |order_detail|
          order_detail.update(making_status: "waiting")
        end
      end
      redirect_to admin_order_path(@order)
    else
      @customer = current_customer
      render :edit
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

  def address_params
    params.require(:order).permit(:name, :address, :postal_code)
  end
end
