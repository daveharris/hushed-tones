class DropboxUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  storage :dropbox

  def store_dir
    "public/michaelaanddave.tokyo/#{model.to_param}"
  end

  def public_url
    "https://dl.dropboxusercontent.com/u/#{self.dropbox_user_id}/#{store_dir.gsub('public/', '')}/#{model.read_attribute(:picture)}"
  end

  # Process files as they are uploaded:
  process :resize_to_fit => [200, 300]

  version :thumb do
    process :resize_to_fit => [50, 50]
  end

  def extension_white_list
    %w(jpg jpeg gif png svg)
  end

end
