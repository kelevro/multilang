module Multilang
  module Redis
    class Config

      def initialize
        @config = load_config
      end

      def to_h
        result             = {}
        result[:host]      = @config['host'] || 'localhost'
        result[:port]      = @config['port'] || 6379
        result[:db]        = @config['db'] || 0
        result[:password]  = @config['password'] if @config['password'].present?
        result[:namespace] = @config['namespace'] || 'multilang'
        result
      end

      def skip?
        @config.empty?
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
