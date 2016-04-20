module Multilang
  module ApplicationHelper

    def method_missing(method, *args, &block)
      if (method.to_s.end_with?('_path') || method.to_s.end_with?('_url')) && main_app.respond_to?(method)
        main_app.send(method, *args)
      else
        super
      end
    end

    def status_tag(status, yes, no)
      if status.present? && yes
        content_tag :span, yes, class: 'label label-success'
      elsif status.blank? && no
        content_tag :span, no, class: 'label label-warning'
      end
    end

    def bootstrap_class_for(flash_type)
      { success: 'alert-success', error: 'alert-danger',
        alert:   'alert-warning', notice: 'alert-info'}[flash_type.to_sym] || flash_type.to_s
    end

    def main_app_root_path
      main_app.send(Multilang.root_path)
    end
  end
end
