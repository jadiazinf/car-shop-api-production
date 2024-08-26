class Models::Create
  attr_accessor :brand_id, :name

  def initialize(params)
    @brand_id = params[:brand_id] unless params[:name].nil?
    @name = params[:name].downcase unless params[:name].nil?
  end

  def handle
    model = Model.find_or_initialize_by(brand_id:, name:)
    if model.persisted?
      [false, I18n.t('active_record.models.errors.taken'), nil]
    elsif model.save
      [true, nil, model]
    else
      [false, model.errors.full_messages, nil]
    end
  end
end
