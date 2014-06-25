$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'fabricators/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'fabricators'
  s.version     = Fabricators::VERSION
  s.authors     = ['Museways']
  s.email       = ['hello@museways.com']
  s.homepage    = 'https://github.com/museways/fabricators'
  s.summary     = 'Fabricators for Rails'
  s.description = 'Minimalistic factory inspired in factory_girl for rails.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency 'rails', (ENV['RAILS_VERSION'] ? "~> #{ENV['RAILS_VERSION']}" : ['>= 3.1.0', '< 4.2.0'])

  if RUBY_PLATFORM == 'java'
    s.add_development_dependency 'activerecord-jdbcsqlite3-adapter', '~> 1.3'
    s.add_development_dependency 'jruby-openssl', '~> 0.9'
  else
    s.add_development_dependency 'sqlite3', '~> 1.3'
  end
end
