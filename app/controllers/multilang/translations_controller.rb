class Multilang::TranslationsController < Multilang::ApplicationController

  add_breadcrumb 'Translations', :translations_path
  before_action :set_searcher, only: [:index]

  def index
    @keys            = @searcher.translation_keys
    @translation_key = Multilang::TranslationKey.new
  end

  def update
    @translation = find_translation params[:id]
    @translation.update_attributes value:        params[:value],
                                   is_completed: true

    Export.new.run if Multilang.force_export

    respond_to do |format|
      format.html { redirect_to translations_url }
      format.js
    end
  end

  def change_status
    @translation = find_translation(params[:id])
    @translation.change_status
    respond_to do |format|
      format.html { redirect_to translations_url }
      format.js
    end
  end

  def save_all
    params[:translations].each do |id, value|
      Multilang::Translation.find(id)
        .update_attributes value:        value,
                           is_completed: true
    end

    render nothing: true
  end
end
