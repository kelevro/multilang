module Multilang
  class Searcher
    attr_reader :search

    # @param [Multilang::Search] search
    def initialize(search)
      @search = search
    end

    def translation_keys
      query = TranslationKey
        .select("#{TranslationKey.table_name}.*", "#{TranslationKey.table_name}.created_at")
        .joins(translations: :language).distinct
      query = key_query(query)
      query = keyword_query(query)
      query = complete_query(query)
      query.order("#{TranslationKey.table_name}.created_at desc")
           .page(@search.page)
    end

    private

    def key_query(query)
      if @search.key.present?
        query = query.where("#{TranslationKey.table_name}.key ilike ?", "#{@search.key}%")
      end
      query
    end

    def keyword_query(query)
      if @search.q.present?
        query = query.where("#{Translation.table_name}.value ilike ?", "%#{@search.q}%")
      end
      query
    end

    def complete_query(query)
      if @search.complete.present? && @search.complete != 'all'
        query = query.where("#{Translation.table_name}.is_completed = ?", @search.complete)
      end
      query
    end
  end
end
