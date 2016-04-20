def locales_path(locale = nil)
  path_params = %w(spec fixtures locales)
  path_params << "#{locale}.yml" if locale.present?
  Multilang::Engine.root.join(*path_params)
end

def add_locales_path_to_default(locale = nil)
  I18n.load_path << locales_path(locale)
end