require 'test_helper'

class TimeExtTest < Test::Unit::TestCase
  def test_to_msgpack_renders_as_string
    str = File.open(File.join(File.dirname(__FILE__), "msgpack_assertion_files", "time_new.mpac")).read
    assert_equal str, "January 4, 2011 2:34:17 PM".to_time.utc.to_msgpack
  end
end

class DateTimeExtTest < Test::Unit::TestCase
  def test_to_msgpack_renders_as_string
    str = File.open(File.join(File.dirname(__FILE__), "msgpack_assertion_files", "datetime_new.mpac")).read
    assert_equal str, "February 3 2010 4:15:09 AM".to_datetime.utc.to_msgpack
  end
end

class DateExtTest < Test::Unit::TestCase
  def test_to_msgpack_renders_as_string
    str = File.open(File.join(File.dirname(__FILE__), "msgpack_assertion_files", "date_new.mpac")).read
    assert_equal str, "March 23 2011".to_date.to_msgpack
  end
end