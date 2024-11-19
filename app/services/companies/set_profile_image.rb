class Companies::SetProfileImage
  def initialize(id, image)
    @company = Company.find(id)
    @image = image
  end

  def perform
    if validate_image == false
      return [false,
              I18n.t('active_record.companies.errors.wrong_profile_image_format')]
    end

    purge_old_image if @company.profile_image.attached?
    attach_new_profile_image
    save
    return [false, @company.errors.full_message] if @company.errors.present?

    [true]
  end

  private

  def validate_image
    return false if @image.nil? || !@image.respond_to?(:path)

    valid_extensions = ['.png', '.jpg', '.jpeg']
    extension = File.extname(@image.path).downcase
    valid_extensions.include?(extension)
  end

  def save
    @company.save
  end

  def purge_old_image
    @company.profile_image.purge
  end

  def attach_new_profile_image
    @company.profile_image.attach(@image)
  end
end
