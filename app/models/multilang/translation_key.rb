module Multilang
  class TranslationKey < ActiveRecord::Base

    has_many :translations, class_name: 'Multilang::Translation',
             foreign_key:               'multilang_translation_key_id',
             dependent:                 :destroy

    validates :key,
              presence:   true,
              uniqueness: true

    after_create :create_translations

    private

    def create_translations
      Multilang::Language.all.each do |lang|
        Multilang::Translation.create! language: lang,
                                       key:      self
      end
    end
  end
end
