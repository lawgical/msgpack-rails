require 'test_helper'

class MsgpackRailsTest < ActiveSupport::TestCase
  test "should register the mpac mime-type" do
    assert_equal Mime::MPAC.to_s, "application/x-mpac"
  end
end
