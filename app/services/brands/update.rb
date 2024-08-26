class Brands::Update
  attr_accessor :id, :new_brand_params

  def initialize(params)
    @id = params[:id]
    @new_brand_params = params[:new_brand_params]
  end

  def perform
    brand = Brand.find(id)
    if brand.update(new_brand_params)
      [true, nil, brand]
    else
      [false, brand.errors.full_messages, nil]
    end
  end
end
