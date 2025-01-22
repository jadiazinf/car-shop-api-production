class Api::V1::QuotesController < ApplicationController
  before_action :authenticate_user!, unless: :devise_controller?
  before_action :set_company, only: %i[index]
  before_action :set_quote, only: %i[show update services]

  def index
    quotes = Quote
      .joins(service: :company)
      .where(services: { company_id: @company.id })
      .select('DISTINCT ON (quotes.group_id) quotes.*')
      .order('quotes.group_id, quotes.created_at DESC')
      .includes(service: :company, vehicle: { model: :brand })

    @quotes = quotes.page(params[:page])
  end

  def show; end

  def create
    service = Quotes::CreateService.new(quote_params)
    success, message = service.perform

    if success
      render json: { message: }, status: :created
    else
      render json: { message: }, status: :unprocessable_entity
    end
  end

  def update
    if @quote.update(quote_params)
      render :show, status: :ok
    else
      render :show, status: :unprocessable_entity
    end
  end

  def services
    @services = Quote.where(group_id: @quote.group_id).includes({ service: :category })
      .map(&:service)
  end

  def by_user
    quotes = Quote
      .joins(service: :company)
      .where(vehicle: { user_id: params[:user_id] })
      .select('DISTINCT ON (quotes.group_id) quotes.*')
      .order('quotes.group_id, quotes.created_at DESC')
      .includes(service: :company, vehicle: { model: :brand })

    @quotes = quotes.page(params[:page])

    render :index, status: :ok
  end

  private

  def quote_params
    if params[:quotes].is_a?(Array)
      params.require(:quotes).map do |quote|
        quote.permit(:id, :group_id, :total_cost, :date, :note, :status_by_company,
                     :status_by_client, :vehicle_id, :service_id).to_h.deep_symbolize_keys
      end
    else
      params.require(:quote).permit(:id, :group_id, :total_cost, :date, :note, :status_by_company,
                                    :status_by_client, :vehicle_id, :service_id)
    end
  end

  def set_quote
    @quote = Quote.includes({ vehicle: :user }, :service).find(params[:id])
  end

  def set_company
    @company = Company.find(params[:company_id])
  end
end
