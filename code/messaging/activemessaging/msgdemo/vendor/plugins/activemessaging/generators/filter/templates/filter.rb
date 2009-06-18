#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class <%= class_name %>Filter < ActiveMessaging::Filter

  attr_accessor :options
  
  def initialize(options={})
    @options = options
  end

  def process(message, routing)
    logger.debug "<%= class_name %>Filter filtering message: #{message.inspect} with routing: #{routing.inspect}"
  end
end