class Brands::Create
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def perform
    brand = Brand.new(name:)
    if brand.save
      [true, nil, brand]
    else
      [false, brand.errors.full_messages, nil]
    end
  end
end
