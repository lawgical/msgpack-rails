require 'test_helper'

class MsgpackSerializerTest < ActiveSupport::TestCase
  def setup
    @person = Person.new
    @person.username = "Mittens the Cat"
    @person.age = 26
    @person.joined_at = "January 4, 2011 2:34:17 PM".to_datetime.utc
  end

  test "should encode all encodable attributes" do
    pck = @person.to_msgpack
    assert_match %r{username.Mittens the Cat}, pck
    assert_match %r{age#{MessagePack.pack(26)}}, pck
    assert_match %r{joined_at.#{Regexp.escape(@person.joined_at.utc.to_s)}}, pck
  end

  test "should be able to encode multiple objects in an array" do
    @person2 = Person.new(:username => "Gloves the Kitten", :age => 34, :joined_at => "February 3, 2010 6:44:00 AM".to_datetime.utc)
    pck = [@person, @person2].to_msgpack

    assert_match %r{username.Gloves the Kitten}, pck
    assert_match %r{username.Mittens the Cat}, pck
  end
end