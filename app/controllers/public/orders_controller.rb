class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
    @address = Address.where(customer_id: current_customer.id)
  end

  def create
    cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if @order.save
      cart_items.each do |cart|
        order_detail= OrderDetail.new
        order_detail.item_id = cart.item_id
        order_detail.order_id = @order.id
        order_detail.amount = cart.amount
        order_detail.price = cart.item.price
        order_detail.save
      end
      redirect_to orders_complete_path
      cart_items.destroy_all
    else
      @customer = current_customer
      @address = Address.where(customer_id: current_customer.id)
      render :new
    end
  end

  def comfirm
    @cart_items = CartItem.all
    @order = Order.new(order_params)
    if params[:order][:address_number] == "1"
      @order.name = current_customer.last_name+current_customer.first_name
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
    elsif params[:order][:address_number] == "2"
      if Address.exists?(id: params[:order][:address_id])
        @address = Address.find(params[:order][:address_id])
        @order.name = @address.name
        @order.postal_code = @address.postal_code
        @order.address = @address.address
      else
        @customer = current_customer
        @address = Address.where(customer_id: current_customer.id)
        render :new
      end
    elsif params[:order][:address_number] == "3"
      address_new = current_customer.addresses.new(address_params)
      if address_new.save
      else
        @customer = current_customer
        @address = Address.where(customer_id: current_customer.id)
        render :new
      end
    end
    @order.shipping_cost = 800
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end


  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method)
  end

  def address_params
    params.require(:order).permit(:name, :address, :postal_code)
  end

end
