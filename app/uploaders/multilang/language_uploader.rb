module Multilang
  class LanguageUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick

    storage :file

    process resize_to_fit: [32, 32]

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

  end
end
