class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  before_action :complete_order?, only: [:show, :update]

  def index
    @orders = Order.all
  end
  def show
    @order = Order.find(params[:id])
  end
  def update
    order = Order.find(params[:id])
    order.update(order_params)
    redirect_to admin_order_path(order), notice: "注文ステータスを更新しました。"
  end
  def item_update
    order_item = OrderItem.find(params[:id])
    order_item.update(order_item_params)
    redirect_to admin_order_path(order_item.order), notice: "制作ステータスを更新しました。"
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end
  def order_item_params
    params.require(:order_item).permit(:status)
  end
end
