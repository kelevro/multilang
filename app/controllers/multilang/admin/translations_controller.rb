module Multilang
  class Admin::TranslationsController < Admin::ApplicationController

    add_breadcrumb 'Translations', :admin_translations_path
    before_action :set_searcher, only: [:index]

    def index
      @keys            = @searcher.translation_keys
      @translation_key = TranslationKey.new
    end

    def update
      @translation = find_translation params[:id]
      @translation.update_attributes value:        params[:value],
                                    is_completed: true
      respond_to do |format|
        format.html { redirect_to admin_translations_url }
        format.js
      end
    end

    def change_status
      @translation = find_translation(params[:id])
      @translation.change_status
      respond_to do |format|
        format.html { redirect_to admin_translations_url }
        format.js
      end
    end

    private

    def set_searcher
      @searcher = Searcher.new(get_search)
    end

    def find_translation(id)
      Translation.find(id)
    end

    def get_search
      Search.new(search_params)
    end

    def search_params
      params.permit(:lang, :q, :complete, :page)
    end

  end
end
