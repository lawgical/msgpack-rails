require 'msgpack'
require "msgpack_rails/core_ext"
require 'msgpack_rails/mime_type'
if Rails::VERSION::MAJOR == 2
  require 'msgpack_rails/2-3/msgpack-rails'
else
  require 'msgpack_rails/3/msgpack-rails'
end

module MsgpackRails
end