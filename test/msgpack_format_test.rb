require 'test_helper'

# Generally-modeled after the ActiveResource formats tests
# NOTE:  ActiveResource endpoint consumption currently not supported for rails 2.3.x
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

      # I have no idea, for some reason when @mittens is first DateTime == String, even if string has wildly different characters in it.
      assert_equal result.joined_at, @mittens[:joined_at]
      assert_equal @mittens[:age], result.age
    end
  end

  def test_msgpack_format_on_collection
    using_format(Endpoint::Person, :msgpack) do
      ActiveResource::HttpMock.respond_to.get "/people.mpac", {'Accept' => ActiveResource::Formats[:msgpack].mime_type}, ActiveResource::Formats[:msgpack].encode(@felines)
      remote_people = Endpoint::Person.find(:all)
      assert_equal 2, remote_people.size
      assert remote_people.select {|p| p.username == 'gloves_kitten'}
    end
  end

  def test_msgpack_format_on_custom_collection_method
    using_format(Endpoint::Person, :msgpack) do
      ActiveResource::HttpMock.respond_to.get "/people/retrieve.mpac?username=gloves_kitten", {'Accept' => ActiveResource::Formats[:msgpack].mime_type}, ActiveResource::Formats[:msgpack].encode([@gloves])
      remote_people = Endpoint::Person.get(:retrieve, :username => 'gloves_kitten')
      assert_equal 1, remote_people.size
      assert_equal @gloves[:id], remote_people[0]['id']
      assert_equal @gloves[:name], remote_people[0]['name']
      assert_equal remote_people[0]['joined_at'], @gloves[:joined_at]
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
end if Rails::VERSION::MAJOR > 2