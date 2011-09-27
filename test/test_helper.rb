# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

#require File.expand_path("../dummy_2_3_14/config/environment.rb", __FILE__)
require File.expand_path("../dummy/config/environment.rb",  __FILE__)

# Officially this gem only works on rails 3+...
# Some (but certainly not all) tests will pass in rails 2.3, but
# don't expect the entire featureset.  See the README.
if Rails::VERSION::MAJOR > 2
  require "rails/test_help"
else
  require 'test/unit'
end

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
