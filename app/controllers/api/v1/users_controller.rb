class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def update
    if @user.update(user_params)
      render :show, status: :ok
    else
      render :show, status: :unprocessable_content
    end
  end

  private

  def user_params
    params.require(:user).permit(:id, :email, :first_name, :last_name, :dni, :birthdate, :address,
                                 :phonenumber, :is_active, roles: [])
  end

  def set_user
    @user = current_user
  end
end
