#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/test_helper'

class TestProcessor < ActiveMessaging::Processor
end

class ConfigTest < Test::Unit::TestCase

  def setup
    ActiveMessaging::Gateway.define do |s|
      s.destination :hello_world, '/queue/helloWorld'
    end
  end
  
  def teardown
    ActiveMessaging::Gateway.reset
  end

  def test_can_subscribe_to_named_queue
    TestProcessor.subscribes_to :hello_world
    sub = ActiveMessaging::Gateway.subscriptions.values.last
    assert_equal :hello_world, sub.destination.name
    assert_equal TestProcessor, sub.processor_class
  end

  def test_can_publish_to_named_queue
    TestProcessor.publishes_to :hello_world
    #no exception - publish just checks to see if the queue exists
  end

  def test_should_raise_error_if_subscribe_to_queue_that_does_not_exist
    assert_raises(RuntimeError) do 
      TestProcessor.subscribes_to :queue_that_does_not_exist
    end
  end

  def test_should_raise_error_if_publishes_to_queue_that_does_not_exist
    assert_raises(RuntimeError) do 
      TestProcessor.publishes_to :queue_that_does_not_exist
    end
  end
  
end