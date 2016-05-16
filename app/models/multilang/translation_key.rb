# == Schema Information
#
# Table name: multilang_translation_keys
#
#  id         :integer          not null, primary key
#  key        :string
#  created_at :datetime
#  updated_at :datetime
#

module Multilang
  class TranslationKey < ActiveRecord::Base

    has_many :translations, class_name: 'Multilang::Translation',
             foreign_key:               'multilang_translation_key_id',
             dependent:                 :destroy

    validates :key,
              presence:   true,
              uniqueness: true

    scope :key, ->(keys) { where(key: keys) }

    def create_translations
      Multilang::Language.all.each do |lang|
        Multilang::Translation.create!(language: lang, key: self)
      end
    end
  end
end
