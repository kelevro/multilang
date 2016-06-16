module Multilang
  module Adapter
    module Injector
      # @return [File]
      def backends
        return @backends if @backends.present?
        @backends = []
        Multilang.backends.each do |key|
          @backends << backend(key)
        end
        @backends
      end

      private

      def backend(backend)
        "::Multilang::Adapter::#{backend.to_s.capitalize}".constantize.new
      end
    end
  end
end
