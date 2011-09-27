require 'test_helper'

# Generally-modeled after the ActiveResource formats tests
class MsgpackFormatTest < Test::Unit::TestCase
  def setup
    # PS.  I hate cats.
    @mittens = {:id => 1, :username => 'mittens_cat', :joined_at => "January 4, 2011 2:34:17 PM".to_datetime.utc, :age => 26}
    @gloves = {:id => 2, :username => 'gloves_kitten', :joined_at => "February 3, 2010 6:44:00 AM".to_datetime.utc, :age => 20}

    @felines = [ @mittens, @gloves ]
  end

  # Currently fails for rails 2.3.14.  Officially this gem only works on rails 3.x
  # Encoding of objects will still work in 2.3.x, but ActiveResource endpoint consumption might not
  def test_msgpack_format_on_single_element
    using_format(Endpoint::Person, :msgpack) do
      ActiveResource::HttpMock.respond_to.get "/people/1.mpac", {'Accept' => ActiveResource::Formats[:msgpack].mime_type}, ActiveResource::Formats[:msgpack].encode(@mittens)
      result = Endpoint::Person.find(1)
      assert_equal @mittens[:username], result.username
      assert_equal @mittens[:joined_at], result.joined_at
      assert_equal @mittens[:age], result.age
    end
  end

  private
    def using_format(klass, mime_type_reference)
      previous_format = klass.format
      klass.format = mime_type_reference

      yield
    ensure
      klass.format = previous_format
    end
end