class Public::CartItemsController < ApplicationController
  before_action :authenticate_end_user!

  def index
    @sum = 0;
    current_end_user.cart_items.each do |item|
      @sum = @sum + (item.item.price*1.1).to_i * item.amount
    end
  end
  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.end_user_id = current_end_user.id
    @cart_item.item_id = params[:id]
    if @cart_item.save
      redirect_to cart_path
    else
      redirect_to item_path(params[:id])
    end
  end
  def item_destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.delete
    redirect_to cart_path
  end
  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_path
    else
      render :index
    end
  end
  def destroy
    current_end_user.cart_items.each do |item|
      item.delete
    end
    redirect_to cart_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:amount)
  end
end
