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
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails'
  s.add_dependency 'pg'
  s.add_dependency 'slim'
  s.add_dependency 'rmagick'

  s.add_dependency 'simple_form'
  s.add_dependency 'client_side_validations'
  s.add_dependency 'client_side_validations-simple_form'
  s.add_dependency 'will_paginate'
  s.add_dependency 'autosize-rails'
  s.add_dependency 'ladda-bootstrap-rails'

end
