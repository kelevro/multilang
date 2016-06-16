module Multilang
  module Adapter
    class File

      # @param [Multilang::Language] language
      def write(language)
        data         = {}
        path         = build_path(language.locale)
        translations = ::Multilang::Translation
                         .where(multilang_language_id: language.id)
                         .includes(:key)
                         .all
        translations.each do |translation|
          keys = translation.key.key.split('.')
          set_value(data, keys, translation.value)
        end
        write_file(path, language.locale => data)
      end

      private

      # @param [String] path
      # @param [Hash] data
      def write_file(path, data)
        ::File.open(path, 'w') { |f| f.write(data.to_yaml) }
      end

      # @param [String] locale
      # @return [String]
      def build_path(locale)
        path = ::File.join(Rails.root, Multilang.locale_path, "#{locale}.yml")
        ::FileUtils.touch(path) unless ::File.exist?(path)
        path
      end

      # @param [Hash] hash
      # @param [Array] keys
      # @param [String] value
      def set_value(hash, keys, value)
        key = keys.shift
        if keys.is_a?(Array) && keys.present?
          hash[key] = {} unless hash.has_key?(key) || hash[key].is_a?(Hash)
          set_value(hash[key], keys, value)
        else
          value = value.to_i if value.present? && value.numeric?
          hash[key] = value
        end
      end
    end
  end
end