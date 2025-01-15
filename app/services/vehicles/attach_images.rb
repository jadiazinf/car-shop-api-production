class Vehicles::AttachImages
  attr_accessor :vehicle, :images

  def initialize(params)
    @vehicle = Vehicle.find_by(id: params[:id])
    @images = params[:images]
  end

  def perform
    purge_old_images
    attach_images
    vehicle.save
    return [false, vehicle.errors] unless vehicle.errors.empty?

    [true, nil]
  end

  private

  def purge_old_images
    vehicle.vehicle_images.purge if vehicle.vehicle_images.attached?
  end

  def attach_images
    return unless images.any?

    images.each do |image|
      vehicle.vehicle_images.attach(image)
    end
  end
end
