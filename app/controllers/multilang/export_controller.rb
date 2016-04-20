module Multilang
  class ExportController < ApplicationController
    def run
      Export.new.run
      flash[:success] = 'Export finished successfully'
      redirect_to :back
    end
  end
end
