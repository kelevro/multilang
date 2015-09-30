module Multilang
  module Admin
    class LanguagesController < ApplicationController
      add_breadcrumb 'Languages', :admin_languages_path
      def index
        @languages = Multilang::Language.sort.all
      end

      def new
        @language = Multilang::Language.new
        add_breadcrumb 'New Language', new_admin_language_path(@language)
      end

      def create
        @language = Multilang::Language.new language_params
        if @language.save
          flash[:success] = 'Language created successfully'
          redirect_to action: :index
        else
          render 'new'
        end
      end

      def edit
        @language = Multilang::Language.find(params[:id])
        add_breadcrumb 'Edit Language', edit_admin_language_path(@language)
      end

      def update
        @language = Multilang::Language.find(params[:id])

        if @language.update(language_params)
          flash[:success] = 'Language updated successfully'
          redirect_to admin_languages_path
        else
          render 'edit'
        end
      end

      def destroy
        language = Multilang::Language.find(params[:id])
        language.destroy
        flash[:success] = "#{language.name} deleted successfully"
        redirect_to action: :index
      end

      def default
        Multilang::Language.set_default(params[:id])
        redirect_to action: :index
      end

      def enable
        language = Multilang::Language.find(params[:id])
        if language.update_attribute :is_enable, true
          flash[:success] = "#{language.name} is now enable"
        else
          flash[:error] = "Can't enable language:#{language.name}"
        end
        redirect_to action: :index
      end

      def disable
        language = Multilang::Language.find(params[:id])

        if language.is_default?
          flash[:error] = 'Cannot disable default language'
        elsif language.update_attribute :is_enable, false
          flash[:success] = "#{language.name} is now disable"
        else
          flash[:error] = "Can't disable language:#{language.name}"
        end
        redirect_to action: :index
      end

      private
        def language_params
          params.require(:language).permit(:name, :locale, :image, :is_enable)
        end
    end
  end
end
