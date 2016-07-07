require 'yaml'

module Multilang
  module Redis
    class Backend
      def configure
        return unless Multilang.backends.include?(:redis)
        config = ::Multilang::Redis::Config.new
        return if config.skip?
        I18n.backend = I18n::Backend::KeyValue.new(::Redis.new(config.to_h))
      end
    end
  end
end
