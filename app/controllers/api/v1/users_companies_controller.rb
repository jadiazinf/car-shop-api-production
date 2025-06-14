class Api::V1::UsersCompaniesController < ApplicationController
  before_action :authenticate_user!, unless: :devise_controller?,
                                     only: %i[user_company_by_user_and_company]
  before_action :authorize_admin_or_superadmin!, only: %i[create update]
  before_action :authorize_admin_and_supervisor!, only: %i[toggle_active update company_users]
  before_action :user_company_params, only: %i[create]
  before_action :set_user_company, only: %i[update show admin toggle_active]

  def show
    UsersActivitiesLogs::Create.new(current_user, 'Show user company info').perform
  end

  def create
    UsersActivitiesLogs::Create.new(current_user, 'Create new company member').perform
    @user_company = UserCompany.new(user_company_params)
    if @user_company.save
      render :show, status: :created
    else
      render :show, status: :bad_request
    end
  end

  def update
    UsersActivitiesLogs::Create.new(current_user, 'Update company member').perform
    if @user_company.update!(user_company_params)
      render :show, status: :ok
    else
      render :show, status: :bad_request
    end
  end

  def admin
    render json: { is_admin: @user_company.roles.include?('admin') }
  end

  def company_users
    UsersActivitiesLogs::Create.new(current_user, 'list company users').perform
    service = UsersCompanies::GetCompanyUsersFilter.new(params)
    @users_company = service.perform
    @users_company = @users_company.page(params[:page])
  end

  def toggle_active
    UsersActivitiesLogs::Create.new(current_user, 'Toggle active state for company member').perform
    @user_company.is_active = !@user_company.is_active
    @user_company.save!
    render json: { is_active: @user_company.is_active }
  end

  def validate_user_company
    UsersActivitiesLogs::Create.new(current_user, 'Validate user company').perform
    service = UsersCompanies::ValidateUserCompany.new(params)
    result = service.perform
    if result
      render json: { user_company: result }, status: :ok
    else
      render json: { user_company: nil }, status: :not_found
    end
  end

  def user_company_by_user_and_company
    @user_company = UserCompany.find_by(user_id: params[:user_id], company_id: params[:company_id])
    render :show, status: :ok
  end

  private

  def set_user_company
    @user_company = UserCompany.find(params[:id])
  end

  def user_company_params
    params.require(:user_company).permit(:id, :company_id, :user_id, :is_active, roles: [])
  end
end
