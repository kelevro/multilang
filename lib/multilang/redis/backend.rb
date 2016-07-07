require 'yaml'

module Multilang
  module Redis
    class Backend
      def configure
        return unless Multilang.backends.include?(:redis)
        # storage      = I18n::Backend::KeyValue.new(::Redis.new(::Multilang::Redis::Config.new.to_h))
        # I18n.backend = I18n::Backend::Chain.new(storage, I18n.backend)
        I18n.backend = I18n::Backend::KeyValue.new(::Redis.new(::Multilang::Redis::Config.new.to_h))
      end
    end
  end
end
