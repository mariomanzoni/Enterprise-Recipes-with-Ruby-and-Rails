#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
# 'abstract' base class for ActiveMessaging filter classes
module ActiveMessaging
  class Filter

    #automatically make it so filters are message senders
    include MessageSender

    # give filters easy access to the logger
    def logger()
      @@logger = ActiveMessaging.logger unless defined?(@@logger)
      @@logger
    end

    # these are the headers available for a message from the 'details' hash
    # :receiver=>processor
    # :destination=>destination object
    # :direction => :incoming

    # :publisher => publisher - optional
    # :destination => destination object
    # :direction => :outgoing

    # if you raise a StopProcessingException, it will cause this to be the last filter to be processed, and will prevent any further processing
    def process(message, routing)
      raise NotImplementedError.new("Implement the process method in your own filter class that extends ActiveMessaging::Filter")
    end

  end
end