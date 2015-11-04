require 'yaml'
require 'fileutils'

module Multilang
  class Export
    def run
      redis
      file
    end

    private

    def redis
      Translation.includes(:key, :language).all.each do |translation|
        I18n.backend.store_translations(translation.language.locale,
                                        { translation.key.key => translation.value },
                                        { escape: false })
      end
    end

    def file
      Language.all.each do |lang|
        data         = {}
        path         = build_path(lang.locale)
        translations = Translation.where(multilang_language_id: lang.id).includes(:key).all
        translations.each do |translation|
          keys = translation.key.key.split('.')
          @tmp = translation.key.key
          set_value(data, keys, translation.value)
        end
        write_file(path, lang.locale => data)
      end
    end

    private

    def build_path(locale)
      path = File.join Rails.root, Multilang.locale_path, "#{locale}.yml"
      unless File.exist?(path)
        FileUtils.touch(path)
      end

      path
    end

    def write_file(path, data)
      File.open(path, 'w') { |f| f.write data.to_yaml }
    end

    # @param [Hash] hash
    # @param [Array] keys
    # @param [String] value
    def set_value(hash, keys, value)
      key = keys.shift
      if keys.is_a?(Array) && keys.present?
        hash[key] = {} unless hash.has_key?(key)
        hash[key] = {} unless hash[key].is_a? Hash
        set_value(hash[key], keys, value)
      else
        value = value.to_i if value.present? && value.numeric?
        hash[key] = value
      end
    end
  end
end
