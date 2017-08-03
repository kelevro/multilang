class Multilang::ApplicationController < ActionController::Base

  add_breadcrumb 'Main app', :main_app_root_path

  before_action :load_translaitons

  layout -> (controller) { controller.request.xhr? ? false : 'multilang/application' }

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

  def load_translaitons
		return unless Rails.env.test?
    Multilang::Import::Redis.new.run if I18n.backend.store.keys.blank?
  end
end
