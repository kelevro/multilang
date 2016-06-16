class Multilang::TranslationKeysController < Multilang::ApplicationController

  before_action :set_searcher, only: [:create]

  # TODO: extract to service
  def create
    @translation_key = Multilang::TranslationKey.new translation_key_params
    @translation_key.tap(&:save).create_translations
    respond_to do |format|
      format.html { redirect_to translations_path }
      format.js
    end
  end

  def destroy
    @translation_key = Multilang::TranslationKey.find(params[:id])
    @translation_key.destroy
    respond_to do |format|
      format.html { redirect_to translations_path }
      format.js
    end
  end

  private
  def translation_key_params
    params.require(:translation_key).permit(:key)
  end
end
