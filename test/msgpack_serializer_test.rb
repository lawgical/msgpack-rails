require 'test_helper'

class MsgpackSerializerTest < Test::Unit::TestCase
  def setup
    @person = Person.new
    @person.username = "Mittens the Cat"
    @person.age = 26
    @person.joined_at = "January 4, 2011 2:34:17 PM".to_datetime.utc
  end

  def test_encode_all_encodable_attributes
    pck = @person.to_msgpack
    assert_match %r{username.Mittens the Cat}, pck
    assert_match %r{age#{MessagePack.pack(26)}}, pck
    assert_match %r{joined_at.+#{Regexp.escape("DateTime[" + @person.joined_at.utc.to_s + "]")}}, pck
  end

  def test_encode_activeresource_attributes
    person = Endpoint::Person.new(:username => "Oreo the Bunny", :age => 6, :joined_at => "February 10, 2012 9:04:00 PM".to_datetime.utc)
    pck = person.to_msgpack
    assert_match %r{username.Oreo the Bunny}, pck
    assert_match %r{age#{MessagePack.pack(6)}}, pck
    assert_match %r{joined_at.+#{Regexp.escape("DateTime[" + person.joined_at.utc.to_s + "]")}}, pck
  end

  def test_encode_multiple_objects_in_array
    @person2 = Person.new(:username => "Gloves the Kitten", :age => 34, :joined_at => "February 3, 2010 6:44:00 AM".to_datetime.utc)
    pck = [@person, @person2].to_msgpack

    assert_match %r{username.Gloves the Kitten}, pck
    assert_match %r{username.Mittens the Cat}, pck
  end
end