class Api::V1::UsersCompaniesController < ApplicationController
  before_action :user_company_params
  before_action :set_user_company, only: %i[update delete show]

  def show; end

  def create
    @user_company = UserCompany.new(user_company_params)
    if @user_company.save
      render json: { user_company: }, status: :created
    else
      render json: { message: 'WHAT DA FUCK' }, status: :bad_request
    end
  end

  def update; end

  def delete; end

  private

  def set_user_company
    @user_company = UserCompany.find(params[:id])
  end

  def user_company_params
    params.require(:user_company).permit(:id, :company_id, :user_id, :roles, :user_id)
  end
end
