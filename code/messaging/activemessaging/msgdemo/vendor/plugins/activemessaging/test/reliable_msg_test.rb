#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/test_helper'

loaded = true
begin
  require 'reliable-msg'
rescue Object => e
  loaded = false
end
if loaded 

class ReliableMsgTest < Test::Unit::TestCase

  def setup
    @qm = ReliableMsg::QueueManager.new
    @qm.start
    @connection = ActiveMessaging::Adapters::ReliableMsg::Connection.new(:reliable=>false, :poll_interval=>2)
    @d = "/queue/reliable.msg.test}."
    @message = "mary had a little lamb"
    @message2 = "whose fleece was white as snow"
  end

  def teardown
    @connection.disconnect unless @connection.nil?
    @qm.stop unless @qm.nil?
  end
  
  def test_subscribe_and_unsubscribe
    assert_nil @connection.subscriptions["#{@d}test_subscribe"]
    @connection.subscribe "#{@d}test_subscribe"
    assert_equal 1, @connection.subscriptions["#{@d}test_subscribe"].count
    @connection.subscribe "#{@d}test_subscribe"
    assert_equal 2, @connection.subscriptions["#{@d}test_subscribe"].count
    @connection.unsubscribe "#{@d}test_subscribe"
    assert_equal 1, @connection.subscriptions["#{@d}test_subscribe"].count
    @connection.unsubscribe "#{@d}test_subscribe"
    assert_nil @connection.subscriptions["#{@d}test_subscribe"]
  end

  def test_send_and_receive
    @connection.subscribe "#{@d}test_send_and_receive"
    @connection.send "#{@d}test_send_and_receive", @message 
    message = @connection.receive
    @connection.received message
    assert_equal @message, message.body
  end


  def test_send_and_receive_multiple_subscriptions
    @connection.subscribe "#{@d}test_send_and_receive1"
    @connection.subscribe "#{@d}test_send_and_receive2"
    @connection.subscribe "#{@d}test_send_and_receive3"

    @connection.send "#{@d}test_send_and_receive2", "message2" 
    message = @connection.receive
    @connection.received message
    assert_equal "message2", message.body

    @connection.send "#{@d}test_send_and_receive3", "message3"
    message = @connection.receive
    @connection.received message
    assert_equal "message3", message.body

  end


  def test_will_cause_sleep

    begin
      Timeout.timeout 10 do
        @connection.subscribe "#{@d}test_will_cause_sleep"
        message = @connection.receive
        @connection.received message
        assert false
      end
    rescue Timeout::Error=>toe
      assert true
    end
  end
  
end

end # if loaded