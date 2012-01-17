class Endpoint::Person < ActiveResource::Base
  self.site = "http://www.example.com"
  self.format = :msgpack
end