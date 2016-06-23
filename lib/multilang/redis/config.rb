module Multilang
  module Redis
    class Config

      def initialize
        config     = load_config
        @host      = config['host'] || 'localhost'
        @port      = config['port'] || 6379
        @db        = config['db'] || 0
        @password  = config['password'] || nil
        @namespace = config['namespace'] || 'multilang'
      end

      def to_h
        result             = {}
        result[:host]      = @host
        result[:port]      = @port
        result[:db]        = @db
        result[:password]  = @password if @password.present?
        result[:namespace] = @namespace
        result
      end

      private

      def load_config
        path = ::File.join(Rails.root, 'config', 'multilang.yml')
        raise ::Multilang::ConfigMissingError unless ::File.exist?(path)
        config = YAML.load_file(path)[Rails.env] || {}
        config['redis'] || {}
      end
    end
  end
end