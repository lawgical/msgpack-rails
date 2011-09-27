$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "msgpack_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "msgpack_rails"
  s.version     = MsgpackRails::VERSION
  s.authors     = ["Nathan Benes"]
  s.email       = ["nbenes@lawgical.com"]
  s.homepage    = "https://github.com/nzifnab/msgpack-rails"
  s.summary     = "Rails gem to utilize msgpack for serializing and deserializing"
  s.description = "For more information see the README."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.0.0"
  s.add_dependency "msgpack"

  s.add_development_dependency "sqlite3"
end
