class Multilang::Admin::TranslationKeysController < Multilang::Admin::ApplicationController

  before_action :set_searcher, only: [:create]

  def create
    authorize! :create, :multilang_translation_key
    @translation_key = Multilang::TranslationKey.new translation_key_params
    @translation_key.save
    respond_to do |format|
      format.html { redirect_to admin_translations_path }
      format.js
    end
  end

  def destroy
    authorize! :destroy, :multilang_translation_key
    @translation_key = Multilang::TranslationKey.find(params[:id])
    @translation_key.destroy
    respond_to do |format|
      format.html { redirect_to admin_translations_path }
      format.js
    end
  end

  private
  def translation_key_params
    params.require(:translation_key).permit(:key)
  end
end
