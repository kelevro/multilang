module Multilang
  class Admin::ExportController < Admin::ApplicationController
    def run
      Export.new.run
      flash[:success] = 'Export finished successfully'
      redirect_to :back
    end
  end
end
