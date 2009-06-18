#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/test_helper'

module ActiveMessaging #:nodoc:
  def self.reload_activemessaging
  end
end

class TestProcessor < ActiveMessaging::Processor
  #subscribes_to :hello_world

  def on_message message
    #do nothing
  end
end

class TestSender < ActiveMessaging::Processor
  #publishes_to :hello_world

end

class FakeMessage
  def command
    'MESSAGE'
  end
  def headers
    {'destination'=>'/queue/helloWorld'}
  end
  def body
    "Ni hao ma?"
  end
end

class TracerTest < Test::Unit::TestCase
  include ActiveMessaging::TestHelper
  def setup
    ActiveMessaging::Gateway.define do |s|
      s.queue :hello_world, '/queue/helloWorld'
      s.queue :trace, '/queue/trace'

      s.filter :trace_filter, :queue=>:trace
    end
    
    TestProcessor.subscribes_to :hello_world
    TestSender.publishes_to :hello_world
  end

  def teardown
    ActiveMessaging::Gateway.reset
  end

  def test_should_trace_sent_messages
    message = "Ni hao ma?"

    sender = TestSender.new
    sender.publish :hello_world, message

    assert_message :trace, "<sent><from>TestSender</from><queue>hello_world</queue><message>#{message}</message></sent>"
    assert_message :hello_world, message
  end

  def test_should_trace_received_messages
    message = "Ni hao ma?"

    ActiveMessaging::Gateway.dispatch FakeMessage.new

    assert_message :trace, "<received><by>TestProcessor</by><queue>hello_world</queue><message>#{message}</message></received>"
  end
end