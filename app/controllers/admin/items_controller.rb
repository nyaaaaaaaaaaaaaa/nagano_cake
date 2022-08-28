class Admin::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(10)
  end

  def new
    @item = Item.new
    @customer = current_customer
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_items_path
  end

  def show
    @item = Item.find(params[:id])
    ##@genre = Genre.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @items = Item.all
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "You have updated item successfully."
      redirect_to admin_items_path
    else
      @customer = current_customer
      render :edit
    end
  end

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
     image
  end


  private

  def item_params
    params.require(:item).permit(:name, :introduction, :image, :price, :is_active, :genre_id)
  end

end
