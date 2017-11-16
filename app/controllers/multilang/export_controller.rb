module Multilang
  class ExportController < ApplicationController
    def run
      Export.new.run
      flash[:success] = 'Export finished successfully'
      redirect_back fallback_location: root_path
    end
  end
end
