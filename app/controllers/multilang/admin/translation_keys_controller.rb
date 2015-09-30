module Multilang
  class Admin::TranslationKeysController < Admin::ApplicationController
    def create
      translation_key = TranslationKey.new translation_key_params
      if translation_key.save!
        flash[:success] = 'Translation key added successfully'
      else
        flash[:error] = 'Cannot add translation key'
      end
      redirect_to admin_translations_path
    end

    def destroy
      @translation_key = TranslationKey.find(params[:id])
      @translation_key.destroy
      respond_to do |format|
        format.html {redirect_to admin_translations_path}
        format.js
      end
    end

    private
      def translation_key_params
        params.require(:translation_key).permit(:key)
      end
  end
end
