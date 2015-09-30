require 'yaml'
require 'pathname'

module Multilang
  class Import

    attr_accessor :path

    def initialize(path)
      pn = Pathname.new(path)
      if pn.relative?
        @path = pn.realpath
      end
    end

    def run
      if @path.directory?
        files = @path.each_child do |file_path|
          file(file_path.realpath) if file_path.file?
        end
      else
        file(@path)
      end
    end

    def file(file_path)
      locale   = locale_by_file(file_path)
      language = Language.where(locale: locale).take
      return if language.blank?
      hash     = parse(file_path, locale)
      hash.each do |key, value|
        translation_key = TranslationKey.where(key: key).take
        if translation_key.blank?
          translation_key = TranslationKey.create! key: key
        end
        translation       = Translation.where(multilang_language_id:        language.id,
                                              multilang_translation_key_id: translation_key.id).take!
        if translation.value.blank?
          translation.value = value
          translation.is_completed = true
          translation.save!
        end
      end
    end

    private

    def parse(file_path, locale)
      yml = YAML::load_file(file_path)
      convert_hash(yml[locale])
    end

    def convert_hash(hash, path='')
      hash.each_with_object({}) do |(k, v), ret|
        key = path + k

        if v.is_a? Hash
          ret.merge! convert_hash(v, key + '.')
        else
          ret[key] = v
        end
      end
    end

    def locale_by_file(file_path)
      locale = File.basename(file_path, '.yml')
      if locale.scan('.').present?
        locale = File.extname(locale).gsub('.', '')
      end
      locale
    end
  end
end
