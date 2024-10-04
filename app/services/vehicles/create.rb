class Vehicles::Create
  attr_accessor :vehicle_params

  def initialize(params)
    @vehicle_params = params
  end

  def perform
    @vehicle = Vehicle.new(vehicle_params)
    if @vehicle.valid?
      attach_images
      @vehicle.save
      [true, nil, @vehicle]
    else
      [false, @vehicle.errors.full_messages, nil]
    end
  end

  def validate_vehicle_props
    unless licence_plate_exists?
      return [false, I18n.t('active_record.vehicles.errors.licence_plate_exists')]
    end
    unless engine_serial_exists?
      return [false, I18n.t('active_record.vehicles.errors.engine_serial_exists')]
    end
    unless body_serial_exists?
      return [false, I18n.t('active_record.vehicles.errors.body_serial_exists')]
    end

    [true, nil]
  end

  private

  def licence_plate_exists?
    v = Vehicle.find_by(licence_plate: @vehicle_params[:license_plate])
    return true if v.present?

    false
  end

  def engine_serial_exists?
    v = Vehicle.find_by(engine_serial: @vehicle_params[:engine_serial])
    return true if v.present?

    false
  end

  def body_serial_exists?
    v = Vehicle.find_by(body_serial: @vehicle_params[:body_serial])
    return true if v.present?

    false
  end

  def attach_images
    @vehicle_params[:vehicle_images].each do |image|
      @vehicle.vehicle_images.attach(image)
    end
  end
end
