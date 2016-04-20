# == Schema Information
#
# Table name: multilang_languages
#
#  id         :integer          not null, primary key
#  locale     :string           not null
#  image      :string
#  name       :string
#  completed  :integer          default(0), not null
#  is_default :boolean          default(FALSE), not null
#  is_enable  :boolean          default(TRUE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

module Multilang
  class Language < ActiveRecord::Base
    mount_uploader :image, LanguageUploader

    has_many :translations, class_name: 'Multilang::Translation',
             foreign_key:               'multilang_language_id',
             dependent: :destroy

    validates :name, presence: true

    validates :locale,
              presence:   true,
              length:     { maximum: 2 },
              uniqueness: { case_sensitive: false }

    validates :image,
              presence: true, on: :create

    scope :sort, -> { order('is_default desc') }
    scope :enable, -> { where(is_enable: true) }
    scope :default, -> { where(is_default: true) }
    scope :locale, -> (locales) { where(locale: locales) }

    after_destroy -> { remove_image! }
    after_create :create_translations

    def self.set_default(id)
      self.update_all is_default: false
      self.find(id).update_attribute(:is_default, true)
    end

    def self.find_by_locale(locale = nil)
      lang = self.where(locale: locale).first
      lang || self.default.first
    end


    def recount_translations
      all             = translations.count
      completed_count = translations.where(is_completed: true).count
      result          = completed_count * 100 / all
      self.update_attribute(:completed, result)
    end

    private

    def create_translations
      TranslationKey.all.each do |key|
        Translation.create! key: key, language: self
      end
    end

  end
end
