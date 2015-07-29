class FilesystemUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Process files as they are uploaded:
  process :resize_to_fit => [200, 300]

  version :thumb do
    process :resize_to_fit => [50, 50]
  end

  # Wwhite list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(jpg jpeg gif png svg)
  end

end
