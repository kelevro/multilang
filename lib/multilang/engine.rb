module Multilang
  class Engine < ::Rails::Engine
    isolate_namespace Multilang

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end

    config.to_prepare do
      Rails.application.config.assets.precompile += %w(multilang/application.css multilang/application.js)
    end

    initializer :load_lacales do |app|
      config.i18n.load_path += app.config.i18n.railties_load_path
    end
  end
end
