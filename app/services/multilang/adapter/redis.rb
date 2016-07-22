module Multilang
  module Adapter
    class Redis
      # @param [Multilang::Language] language
      def write(language)
        language.translations.includes(:key).find_each do |translation|
          next unless translation.key
          store_translation(language.locale,
                            translation.key.key,
                            translation.value)
        end
      end

      private

      def store_translation(locale, key, value)
        I18n.backend.store_translations(locale, { key => value }, { escape: false })
      end
    end
  end
end
