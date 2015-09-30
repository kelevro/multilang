module Multilang
  class Admin::ApplicationController < ApplicationController
    add_breadcrumb 'Main app', :admin_path
    layout 'multilang/admin/applicaton'
    def initialize
      super
      I18n.locale = :en
    end
  end
end
