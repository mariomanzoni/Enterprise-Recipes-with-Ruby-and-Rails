#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/test_helper'

class OpenIdAuthenticationTest < Test::Unit::TestCase
  def setup
    @controller = Class.new do
      include OpenIdAuthentication
      def params() {} end
    end.new
  end

  def test_authentication_should_fail_when_the_identity_server_is_missing
    open_id_consumer = mock()
    open_id_consumer.expects(:begin).raises(OpenID::OpenIDError)
    @controller.stubs(:open_id_consumer).returns(open_id_consumer)

    @controller.send(:authenticate_with_open_id, "http://someone.example.com") do |result, identity_url|
      assert result.missing?
      assert_equal "Sorry, the OpenID server couldn't be found", result.message
    end
  end

  def test_authentication_should_fail_when_the_identity_server_times_out
    open_id_consumer = mock()
    open_id_consumer.expects(:begin).raises(Timeout::Error, "Identity Server took too long.")
    @controller.stubs(:open_id_consumer).returns(open_id_consumer)

    @controller.send(:authenticate_with_open_id, "http://someone.example.com") do |result, identity_url|
      assert result.missing?
      assert_equal "Sorry, the OpenID server couldn't be found", result.message
    end
  end

  def test_authentication_should_begin_when_the_identity_server_is_present
    @controller.stubs(:open_id_consumer).returns(stub(:begin => true))
    @controller.expects(:begin_open_id_authentication)
    @controller.send(:authenticate_with_open_id, "http://someone.example.com")
  end
end
