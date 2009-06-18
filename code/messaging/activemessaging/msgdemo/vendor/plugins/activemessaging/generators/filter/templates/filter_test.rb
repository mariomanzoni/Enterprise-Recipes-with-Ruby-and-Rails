#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'
require File.dirname(__FILE__) + '/../../vendor/plugins/activemessaging/lib/activemessaging/test_helper'

class <%= class_name %>FilterTest < Test::Unit::TestCase
  include ActiveMessaging::TestHelper
  
  def setup
    # if you want to write code to tests against the filter directly
    load File.dirname(__FILE__) + "/../../app/processors/<%= file_name %>_filter.rb"
    @options = {:direction=>:incoming, :only=>:<%= file_name %>_test}
    @filter = <%= class_name %>Filter.new(@options)
    @destination = ActiveMessaging::Gateway.destination :<%= file_name %>_test, '/queue/<%= file_name %>.test.queue'
  end
  
  def teardown
    ActiveMessaging::Gateway.reset
    @filter = nil
    @destination = nil
    @options = nil
  end  

  def test_<%= file_name %>_filter
    @message = ActiveMessaging::TestMessage.new(@destination.value, {'message-id'=>'test-message-id-header'}, 'message body')
    @routing = {:direction=>:incoming, :destination=>@destination}
    @filter.process(@message, @routing)
  end

end