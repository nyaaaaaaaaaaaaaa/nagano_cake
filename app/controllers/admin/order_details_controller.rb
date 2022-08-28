class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:order_detail][:order_detail_id])
    if @order_detail.update(order_detail_params)
      flash[:notice] = "You have updated order_details successfully."
      if @order_detail.making_status == "creating"
        @order_detail.order.update(status: "creating")
      end
      redirect_to admin_order_path(@order_detail.order)
    else
      @customer = current_customer
    end
  end

  private


  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
