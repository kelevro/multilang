  class Multilang::Admin::ApplicationController < Multilang::ApplicationController
    add_breadcrumb 'Main app', :admin_path

    before_action :authenticate_admin_manager!
    layout 'multilang/admin/applicaton'

    check_authorization

    def initialize
      super
      I18n.locale = :en
    end

    def current_ability
      @current_ability ||= current_admin_manager.ability
    end

    def authenticate_admin_manager!
      if admin_manager_signed_in?
        super
      else
        redirect_to main_app.admin_login_path
      end
    end

    private

    def set_searcher
      @searcher = Multilang::Searcher.new(get_search)
    end

    def find_translation(id)
      Multilang::Translation.find(id)
    end

    def get_search
      Multilang::Search.new(search_params)
    end

    def search_params
      params.permit(:lang, :q, :complete, :page, :key)
    end

  end
