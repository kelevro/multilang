$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'multilang/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'multilang'
  s.version     = Multilang::VERSION
  s.authors     = ['Anton Holovko']
  s.email       = ['anton.holovko.b@gmail.com']
  s.homepage    = ''
  s.summary     = 'Summary of Multilang.'
  s.description = 'Description of Multilang.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails', '4.2.6'
  s.add_dependency 'pg'
  s.add_dependency 'mini_magick'
  s.add_dependency 'carrierwave'

  s.add_dependency 'simple_form'
  s.add_dependency 'kaminari'
  s.add_dependency 'bootstrap-sass'
  s.add_dependency 'breadcrumbs_on_rails'
  s.add_dependency 'font-awesome-sass'
end
