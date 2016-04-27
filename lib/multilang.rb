require 'mini_magick'
require 'carrierwave'
require 'kaminari'
require 'bootstrap-sass'
require 'breadcrumbs_on_rails'
require 'simple_form'
require 'font-awesome-sass'

require 'multilang/engine'

module Multilang
  mattr_accessor :locale_path do
    File.join 'config', 'locales'
  end

  mattr_accessor :root_path do
    :root_path
  end

  mattr_accessor :force_export do
    false
  end

  def self.configure
    yield self
  end
end
