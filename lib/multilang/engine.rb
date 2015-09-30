module Multilang
  class Engine < ::Rails::Engine
    isolate_namespace Multilang
    config.to_prepare do
      Rails.application.config.assets.precompile += %w(multilang/admin.css multilang/admin.js)
    end
    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths['db/migrate'].expanded.each do |expanded_path|
          app.config.paths['db/migrate'] << expanded_path
        end
      end
    end
    initializer :load_lacales do |app|
      config.i18n.load_path += app.config.i18n.railties_load_path
    end
  end
end
