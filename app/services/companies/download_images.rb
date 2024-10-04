require 'zip'

class Companies::DownloadImages
  def initialize(company)
    @company = company
  end

  def perform
    if @company.company_images.attached?
      zip_path = create_zip_file
      { ok: true,
        data: { zip: zip_path, filename: File.basename(zip_path), type: 'application/zip',
                disposition: 'attachment' } }
    else
      { ok: false, message: 'Company images not found' }
    end
  end

  private

  def create_zip_file
    zipfile_name = "#{@company.name}_images.zip"
    zip_path = Rails.root.join('tmp', zipfile_name)

    Zip::File.open(zip_path, Zip::File::CREATE) do |zipfile|
      @company.company_images.each_with_index do |image, index|
        add_image_to_zip(zipfile, image, index + 1)
      end
    end

    zip_path
  end

  def add_image_to_zip(zipfile, image, index)
    zipfile.get_output_stream("#{index}_#{image.filename}") do |f|
      f.write image.download
    end
  end
end
