class Api::V1::CompaniesController < ApplicationController
  # before_action :set_company, only: [:show, :edit, :update, :destroy]

  def create
    @company = Company.new(company_params)

    if @company.save
      render_success_response(@company)
    else
      render_bad_request(@company.errors)
    end
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :dni, :company_charter, :email, :number_of_employees,
                                    :address, :request_status, :location_id, payment_methods: [],
                                                                             social_networks: [],
                                                                             phonenumbers: [])
  end
end
