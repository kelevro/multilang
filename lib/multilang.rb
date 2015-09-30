require 'multilang/engine'

module Multilang
  mattr_accessor :locale_path do
    File.join 'config', 'locales'
  end
end
