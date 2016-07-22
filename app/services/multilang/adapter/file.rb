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

        translations.find_each do |translation|
          next unless translation.key
          keys = translation.key.key.split('.')
          data.deep_merge!(build_hash(keys, translation.value))
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

      def build_hash(arr, value)
        if arr.empty?
          value
        else
          {}.tap do |hash|
            hash[arr.shift] = build_hash(arr, value)
          end
        end
      end
    end
  end
end
