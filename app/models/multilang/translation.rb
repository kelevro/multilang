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

    def change_status
      if is_completed?
        self.update_attribute :is_completed, false
      else
        self.update_attribute :is_completed, true
      end
    end
  end
end
