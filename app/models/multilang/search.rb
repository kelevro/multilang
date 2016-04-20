module Multilang
  class Search
    include ActiveModel::Model
    attr_accessor :q, :key, :lang, :complete, :page

    def initialize(attributes = {})
      super
      @lang     ||= 'all'
      @complete ||= 'all'
    end

    def languages_list
      [['All locales', :all]].concat(Language.pluck(:name, :id))
    end

    def language
      return @lang_params if @lang_params.present?
      if @lang == 'all'
        @lang_params = { default: 'all' }
      else
        language = Language.find(@lang)
        if language.is_default?
          @lang_params = { default: language }
        else
          default      = Language.where(is_default: true).first
          @lang_params = { default: default, lang: language }
        end
      end
      @lang_params
    end
  end
end
