require 'minitest/autorun'
require 'minitest/pride'
require_relative '../db/setup'
require_relative '../bin/run'

class ReqResTest < Minitest::Test

  def test_check_id
    test_target = parse("GET http://www.google.com HTTP/1.1")
    test_params = test_target[:params]
    assert Checkers.id_check(test_target, test_params)
  end

end
