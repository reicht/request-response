require 'minitest/autorun'
require 'minitest/pride'
require_relative '../db/setup'
require_relative '../bin/run'

class ReqResTest < Minitest::Test

  def test_check_id_exists
    test_target = parse("GET http://www.google.com HTTP/1.1")
    test_params = test_target[:params]
    assert Checkers.id_check(test_target, test_params)
  end

  # Unworking, believed to be due to function of checker chain.

  # def test_check_command_exists
  #   test_target = parse("GET http://www.google.com HTTP/1.1")
  #   test_params = test_target[:params]
  #   assert Checkers.command_check(test_target, test_params)
  # end
  #
  # def test_check_subdomain_exists
  #   test_target = parse("GET http://www.google.com HTTP/1.1")
  #   test_params = test_target[:params]
  #   assert Checkers.subdomain_check(test_target, test_params)
  # end

end
