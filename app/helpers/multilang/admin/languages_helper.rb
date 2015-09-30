module Multilang
  module Admin::LanguagesHelper
    def percent_bar(val)
      content_tag :div, class: 'progress' do
        tag :div, class: 'progress-bar progress-bar-success', role: 'progressbar',
            'aria-valuenow': val, 'aria-valuemax': 100, style: "width: #{val}%"
      end
    end
  end
end
