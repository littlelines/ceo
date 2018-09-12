$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ceo/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ceo"
  s.version     = CEO::VERSION.dup
  s.authors     = ['Jesse Herrick']
  s.email       = ['jesse@littlelines.com']
  s.homepage    = 'https://github.com/littlelines/ceo'
  s.summary     = 'An admin tool that puts object oriented design over DSLs.'
  s.description = 'A useful admin tool that gets out of your way'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '> 4'
  s.add_dependency 'autoprefixer-rails'
  s.add_dependency 'inline_svg'
  s.add_dependency 'sassc-rails'
  s.add_dependency 'simple_form'

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'maxitest'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'pg'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'pry-nav'
end
