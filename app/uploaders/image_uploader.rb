class ImageUploader < CarrierWave::Uploader::Base
  # storage :file
  include Cloudinary::CarrierWave
end
