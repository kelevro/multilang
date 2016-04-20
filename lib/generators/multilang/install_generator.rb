module Multilang
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc 'Copy Multilang default files'

      source_root File.expand_path('../templates', __FILE__)

      def copy_initializers
        copy_file 'initializers/multilang.rb', 'config/initializers/multilang.rb'
      end
    end
  end
end

