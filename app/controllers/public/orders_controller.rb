class Public::OrdersController < ApplicationController
  before_action :authenticate_end_user!
  before_action :cart_item?, only: [:new, :create]
  before_action :unsettled_order!, only: [:new, :create]
  before_action :unsettled_order?, only: [:verification, :complete]

  def new
    @order = Order.new
    @item = Item.new
    @address = ShippingAddress.where(end_user_id: current_end_user.id)
  end
  def create
    if params[:flag] == "1"
      @order = Order.new(order_pay_params)
      @order.name = current_end_user.first_name + current_end_user.last_name
      @order.postal_code = current_end_user.postal_code
      @order.address = current_end_user.address
    elsif params[:flag] == "2"
      address = ShippingAddress.find(params[:address].to_i)
      @order = Order.new(order_pay_params)
      @order.name = address.name
      @order.postal_code = address.postal_code
      @order.address = address.address
    elsif params[:flag] == "3"
      @order = Order.new(order_params)
      address = ShippingAddress.new
      address.end_user_id = current_end_user.id
      address.name = @order.name
      address.postal_code = @order.postal_code
      address.address = @order.address
      unless address.save
        @item = Item.new
        @address = ShippingAddress.where(end_user_id: current_end_user.id)
        render :new and return
      end
    else
      redirect_to new_order_path, notice: "正常に処理できませんでした。もう一度、お願いします" and return
    end
    @order.postage = 800
    @order.end_user_id = current_end_user.id
    sum = 0
    current_end_user.cart_items.each do |item|
      sum = sum + (item.item.price*1.1).to_i * item.amount
    end
    @order.total_price = @order.postage + sum
    if @order.save
      current_end_user.cart_items.each do |item|
        order_item = OrderItem.new
        order_item.order_id = @order.id
        order_item.item_id = item.item.id
        order_item.price = (item.item.price*1.1).to_i
        order_item.amount = item.amount
        if order_item.save
          item.destroy
        else
          @item = order_item
          @address = ShippingAddress.where(end_user_id: current_end_user.id)
          render :new and return
        end
      end
      redirect_to verification_order_path
    else
      @item = Item.new
      @address = ShippingAddress.where(end_user_id: current_end_user.id)
      render :new
    end
  end
  def verification
    @order = Order.where(status: 0).find_by(end_user_id: current_end_user.id)
  end
  def complete
    @order = Order.where(status: 0).find_by(end_user_id: current_end_user.id)
    @order.update(status: 1)
    redirect_to done_order_path
  end
  def destroy
    @order = Order.where(status: 0).find_by(end_user_id: current_end_user.id)
    @order.destroy
    redirect_to items_path, notice: "注文を取り消しました"
  end
  def done
  end

  private
  def order_pay_params
    params.require(:order).permit(:pay_way)
  end
  def order_params
    params.require(:order).permit(:name, :postal_code, :address, :pay_way)
  end
end
