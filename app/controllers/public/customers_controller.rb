class Public::CustomersController < ApplicationController
  def show
   ## @customer = customer_session.find(params[:id])
    @customer = current_customer
  end

  def edit
    @customer = current_customer
   ## @customer = customer_session.find(params[:id])
  end

  def update
    @customer = current_customer
    ##@customer = customer_session.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "You have updated customer successfully."
      redirect_to customers_information_edit_path(@customer)
    else
      @customer = current_customer
      render :edit
    end
  end

  def destroy
    @customer = current_customer
    customer.destroy
    redirect_to '/'
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to '/'
  end


  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
  end

end
