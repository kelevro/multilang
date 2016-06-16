Multilang.configure do |config|
  config.root_path    = :root_path
  config.force_export = true
  config.backends = :redis
end
