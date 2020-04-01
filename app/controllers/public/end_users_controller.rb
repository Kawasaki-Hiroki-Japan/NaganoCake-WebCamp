class Public::EndUsersController < ApplicationController
  before_action :authenticate_end_user!
  def show
  end
  def edit
  end
  def update
    end_user = current_end_user
    if end_user.update(end_user_params)
      redirect_to end_user_path
    else
      render :edit
    end
  end
  def withdraw
  end
  def destroy
    end_user = current_end_user
    end_user.update(status: :false)
    end_user.destroy
    redirect_to new_end_user_session_path
  end

  private
  def end_user_params
    params.require(:end_user).permit(:first_name, :last_name, :first_kana, :last_kana, :postal_code, :address, :phone_number, :email)
  end
end
