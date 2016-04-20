# == Schema Information
#
# Table name: multilang_translations
#
#  id                           :integer          not null, primary key
#  multilang_language_id        :integer
#  multilang_translation_key_id :integer
#  value                        :text
#  is_completed                 :boolean
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#

module Multilang
  class Translation < ActiveRecord::Base
    belongs_to :language, class_name: 'Multilang::Language',
               foreign_key: 'multilang_language_id'
    belongs_to :key, class_name: 'Multilang::TranslationKey',
               foreign_key: 'multilang_translation_key_id'

    after_save -> do
      if is_completed_changed?
        language.recount_translations
      end
    end

    def self.langs(default:, lang: nil)
      query = self.includes(:language).references(:language)
      if default != 'all'
        if lang.present?
          query = query.where("#{table_name}.multilang_language_id = ?
                                or #{table_name}.multilang_language_id = ?",
                              default.id, lang.id)
        else
          query = query.where("#{table_name}.multilang_language_id = ?",
                              default.id)
        end
      end
      query.order("#{Language.table_name}.is_default desc")
    end

    def change_status
      if is_completed?
        self.is_completed = false
      else
        self.is_completed = true
      end
      self.save!
    end

  end
end
