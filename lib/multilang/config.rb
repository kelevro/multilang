module Multilang
  module Config
    UnallowedBackendError = Class.new(StandardError)

    ALLOWED_BACKENDS = [:file, :redis]

    mattr_accessor :locale_path do
      File.join 'config', 'locales'
    end

    mattr_accessor :root_path do
      :root_path
    end

    mattr_accessor :force_export do
      false
    end

    mattr_reader :backends do
      [:file]
    end

    def configure
      yield self
      validate
    end

    def backends=(backends)
      backends = [backends] unless backends.is_a?(Array)
      backends << :file unless backends.include?(:file)
      @@backends = backends
    end

    private

    def validate
      validate_backends
    end

    def validate_backends
      backends.map do |backend|
        raise UnallowedBackendError unless ALLOWED_BACKENDS.include?(backend)
      end
    end
  end
end