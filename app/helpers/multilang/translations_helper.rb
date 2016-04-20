module Multilang
  module TranslationsHelper
    def status_control(translation)
      if translation.is_completed?
        render partial: 'multilang/translations/complete_control',
               locals: {translation: translation}
      else
        render partial: 'multilang/translations/incomplete_control',
               locals: {translation: translation}
      end
    end
  end
end
