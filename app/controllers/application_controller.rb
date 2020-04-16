class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:email, :password, :remember_me)
    end
  end
  def after_sign_in_path_for(resource)
    case resource
      when EndUser
        end_user_path
      when Admin
        admin_items_path
    end
  end
  def after_sign_out_path_for(resource)
    if resource == :end_user
      new_end_user_session_path
    else
      new_admin_session_path
    end
  end
  def cart_item?
    redirect_to items_path, notice: "カートが空です。" unless CartItem.find_by(end_user_id: current_end_user.id)
  end
  def item_added?
    redirect_to item_path(params[:id]), notice: "既にこの商品はカートに入っています。" if CartItem.where(end_user_id: current_end_user.id).find_by(item_id: params[:id])
  end
  def unsettled_order?
    redirect_to cart_path unless Order.where(status: 0).find_by(end_user_id: current_end_user.id)
  end
  def unsettled_order!
    redirect_to verification_order_path, notice: "未確定の注文があります。" if Order.where(status: 0).find_by(end_user_id: current_end_user.id)
  end
  def complete_order?
    if Order.find_by(params[:id]) == false
      redirect_to admin_orders_path, notice: "注文IDが異なります。"
    elsif Order.find(params[:id]).status == 0
      redirect_to admin_orders_path, notice: "注文IDが異なります。"
    end
  end
end
