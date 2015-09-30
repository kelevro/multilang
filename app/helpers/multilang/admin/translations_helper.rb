module Multilang
  module Admin::TranslationsHelper
    def status_control(translation)
      if translation.is_completed?
        render partial: 'multilang/admin/translations/complete_control',
               locals: {translation: translation}
      else
        render partial: 'multilang/admin/translations/incomplete_control',
               locals: {translation: translation}
      end
    end
  end
end
