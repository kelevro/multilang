module Multilang
  class Search
    include ActiveModel::Model
    attr_accessor :q, :lang, :complete, :page

    def initialize(attributes = {})
      super
      @lang ||= 'all'
      @complete ||= 'all'
    end

    def languages_list
      [['All locales', :all]].concat(Language.pluck(:name, :id))
    end

  end
end
