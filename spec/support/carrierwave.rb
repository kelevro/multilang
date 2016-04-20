if defined?(CarrierWave)
  CarrierWave.configure do |config|
    config.storage           = :file
    config.enable_processing = false
  end

  Dir["#{Multilang::Engine.root}/app/uploaders/**/*.rb"].each {|file| require file}
  CarrierWave::Uploader::Base.descendants.each do |klass|
    next if klass.anonymous?
    klass.class_eval do
      def cache_dir
        "#{Multilang::Engine.root}/spec/support/uploads/tmp"
      end

      def store_dir
        "#{Multilang::Engine.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      end
    end
  end
end