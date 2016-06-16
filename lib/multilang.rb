require 'mini_magick'
require 'carrierwave'
require 'kaminari'
require 'bootstrap-sass'
require 'breadcrumbs_on_rails'
require 'simple_form'
require 'font-awesome-sass'

require 'multilang/engine'
require 'multilang/config'
require 'multilang/redis/backend'
require 'multilang/redis/config'

module Multilang
  ConfigMissingError = Class.new(StandardError)
  extend Config
end
