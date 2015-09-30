module Multilang
  class Searcher
    attr_reader :search

    # @param [Multilang::Search] search
    def initialize(search)
      @search = search
    end

    def translation_keys
      query = TranslationKey.order("#{TranslationKey.table_name}.created_at desc")
                .includes(translations: [:language])
                .references(:translations, :language)
                .where(conditions)
                .order("#{Language.table_name}.is_default desc, #{Language.table_name}.created_at")

      query.paginate(page: @search.page)
    end

    private

    def language_conditions
      return if @search.lang == 'all'
      if Language.find(@search.lang).is_default?
        ["#{Translation.table_name}.multilang_language_id = ?", @search.lang]
      else
        default = Language.where(is_default: true).take!
        ["#{Translation.table_name}.multilang_language_id = ? or #{Translation.table_name}.multilang_language_id = ?",
         @search.lang, default.id]
      end
    end

    def complete_conditions
      ["#{Translation.table_name}.is_completed = ?", @search.complete] unless @search.complete == 'all'
    end

    def keyword_conditions
      ["#{Translation.table_name}.value like ?", "%#{@search.q}%"] if @search.q.present?
    end


    def conditions
      [conditions_clauses.join(' AND '), *conditions_options]
    end

    def conditions_clauses
      conditions_parts.map { |condition| condition.first }
    end

    def conditions_options
      conditions_parts.map { |condition| condition[1..-1] }.flatten
    end

    def conditions_parts
      private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
    end
  end
end
