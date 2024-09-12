class Api::V1::CompaniesController < ApplicationController
  def create
    @company = Company.new(company_params)
    if @company.save
      company_creation_request = CompanyCreationRequests::Create.new(company_id: @company.id)
      company_creation_request.perform
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
