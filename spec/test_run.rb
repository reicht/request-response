require 'minitest/autorun'
require 'minitest/pride'
require_relative '../db/setup'
require_relative '../bin/run'

class ReqResTest < Minitest::Test

  def test_can_parse
    tester = parse('http://www.google.com')
    assert tester
  end

end
