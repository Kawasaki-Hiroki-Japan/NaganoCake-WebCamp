class Public::ItemsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :end_user_item_restriction, only: [:show]

  def index
    @items = Item.all
    @genre = Genre.all
  end
  def show
    @item = Item.find(params[:id])
    @genre = Genre.all
    @cart_item = CartItem.new
  end

  private
  def end_user_item_restriction
    unless Item.find_by(id: params[:id])
      redirect_to items_path
    else
      redirect_to items_path unless Item.find(params[:id]).status
    end
  end
end
