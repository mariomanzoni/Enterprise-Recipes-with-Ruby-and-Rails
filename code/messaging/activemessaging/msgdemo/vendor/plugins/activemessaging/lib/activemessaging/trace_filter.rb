#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
class TraceFilter< ActiveMessaging::Filter
  include ActiveMessaging::MessageSender
  
  def initialize(options)
    @queue = options[:queue]
    TraceFilter.publishes_to @queue
  end
  
  def process message, routing
    
    unless ( routing[:destination].name == @queue ) then
      puts "\nTrace: direction = #{routing[:direction]} publisher=#{routing[:publisher]} queue=#{routing[:destination].name} @queue=#{@queue}\n"
      if routing[:direction].to_sym==:outgoing then
        "trace from outgoing"
        publish @queue, "<sent>"+
                        "<from>#{routing[:publisher]}</from>" +        
                        "<queue>#{routing[:destination].name}</queue>" +
                        "<message>#{message.body}</message>" + 
                        "</sent>"
      end
      if routing[:direction].to_sym==:incoming then
        "trace from incoming"
        publish @queue, "<received>"+
                        "<by>#{routing[:receiver]}</by>" +        
                        "<queue>#{routing[:destination].name}</queue>" +
                        "<message>#{message.body}</message>" + 
                        "</received>"
      end
    end

  end
  
end

