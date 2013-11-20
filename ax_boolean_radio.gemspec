$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ax_boolean_radio/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ax_boolean_radio"
  s.version     = AxBooleanRadio::VERSION
  s.authors     = ['azimux']
  s.email       = ['azimux@gmail.com']
  s.homepage    = 'http://github.com/azimux/ax_boolean_radio'
  s.summary     = 'Engine for radio buttons in forms'
  s.description = 'Engine for radio buttons in forms'

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT_LICENSE.txt"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.12"

  s.add_development_dependency "sqlite3"
end
