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
      when EndUsers
        end_user_path(resouce)
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
    # new_end_user_session_path
  end

end
