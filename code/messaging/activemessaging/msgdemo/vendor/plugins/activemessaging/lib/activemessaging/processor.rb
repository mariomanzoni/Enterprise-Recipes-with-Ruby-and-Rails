#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
# 'abstract' base class for ActiveMessaging processor classes
module ActiveMessaging

  class Processor
    include MessageSender
    
    attr_reader :message
  
    class<<self
      def subscribes_to destination_name, headers={}
        ActiveMessaging::Gateway.subscribe_to destination_name, self, headers
      end
    end

    def logger()
      @@logger = ActiveMessaging.logger unless defined?(@@logger)
      @@logger
    end
    
    def on_message(message)
      raise NotImplementedError.new("Implement the on_message method in your own processor class that extends ActiveMessaging::Processor")
    end

    def on_error(exception)
      raise exception
    end
    
    # Bind the processor to the current message so that the processor could
    # potentially access headers and other attributes of the message
    def process!(message)
      @message = message
      return on_message(message.body)
    rescue Exception
      begin
        on_error($!)
      rescue ActiveMessaging::AbortMessageException => rpe
        logger.error "Processor:process! - AbortMessageException caught."
        raise rpe
      rescue Exception => ex
        logger.error "Processor:process! - error in on_error, will propagate no further: #{ex.message}"
      end
    end

  end
end