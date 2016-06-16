require 'yaml'
require 'fileutils'

module Multilang
  class Export
    include ::Multilang::Adapter::Injector

    def run
      Language.all.each do |language|
        backends.map { |backend| backend.write(language) }
      end
      I18n.backend.reload!
    end
  end
end
