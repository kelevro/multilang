class Multilang::Admin::TranslationsController < Multilang::Admin::ApplicationController

  add_breadcrumb 'Translations', :admin_translations_path
  before_action :set_searcher, only: [:index]

  def index
    authorize! :index, :multilang_translation
    @keys            = @searcher.translation_keys
    @translation_key = Multilang::TranslationKey.new
  end

  def update
    authorize! :update, :multilang_translation
    @translation = find_translation params[:id]
    @translation.update_attributes value:        params[:value],
                                   is_completed: true
    respond_to do |format|
      format.html { redirect_to admin_translations_url }
      format.js
    end
  end

  def change_status
    authorize! :change_status, :multilang_translation
    @translation = find_translation(params[:id])
    @translation.change_status
    respond_to do |format|
      format.html { redirect_to admin_translations_url }
      format.js
    end
  end
end
