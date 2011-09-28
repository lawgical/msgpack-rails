require 'test_helper'

class MsgpackRailsTest < Test::Unit::TestCase
  def test_register_mpac_mime_type
    assert_equal Mime::MPAC.to_s, "application/x-mpac"
  end
end
