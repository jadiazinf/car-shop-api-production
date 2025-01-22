class Quotes::CreateService
  def initialize(params)
    @params = params
  end

  def perform
    validate_params!
    start_transactions
    [true, 'Quotes created successfully']
  rescue ActiveRecord::RecordInvalid => e
    [false, "Failed to create quotes: #{e.message}"]
  rescue StandardError => e
    [false, "An unexpected error occurred: #{e.message}"]
  end

  private

  def uuid
    SecureRandom.uuid
  end

  def start_transactions
    Quote.transaction do
      @params.each do |quote_params|
        create_quote(quote_params)
      end
    end
  end

  def validate_params!
    raise ArgumentError, 'Params must be an array' unless @params.is_a?(Array)

    @params.each do |quote_params|
      unless quote_params.is_a?(Hash)
        raise ArgumentError, "Each quote must be a hash, but received: #{quote_params.class}"
      end

      required_keys = %i[total_cost date note status_by_company status_by_client service_id]
      missing_keys = required_keys - quote_params.keys
      raise ArgumentError, "Missing required key: #{missing_keys.first}" if missing_keys.any?
    end
  end

  def create_quote(quote_params)
    Quote.create!(
      quote_params.merge(group_id: uuid)
    )
  end

  def log_error(error)
    Rails.logger.error("[Quotes::CreateService] #{error.class}: #{error.message}")
    Rails.logger.error(error.backtrace.join("\n"))
  end
end
