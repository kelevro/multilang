require 'multilang/engine'

module Multilang
  mattr_accessor :locale_path do
    File.join 'config', 'locales'
  end

  mattr_accessor :root_path do
    :root_path
  end

  def self.configure
    yield self
  end
end
