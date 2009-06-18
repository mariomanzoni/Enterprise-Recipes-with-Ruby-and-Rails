#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
if defined?(ActiveRecord::Base)
  module ActiveRecord #:nodoc:
    class Base

      (class << self; self; end).class_eval do
        # Extension for <tt>should have</tt> on AR Model classes
        #
        #   ModelClass.should have(:no).records
        #   ModelClass.should have(1).record
        #   ModelClass.should have(n).records
        def records
          find(:all)
        end
        alias :record :records
      end

      # Extension for <tt>should have</tt> on AR Model instances
      #
      #   model.should have(:no).errors_on(:attribute)
      #   model.should have(1).error_on(:attribute)
      #   model.should have(n).errors_on(:attribute)
      def errors_on(attribute)
        self.valid?
        [self.errors.on(attribute)].flatten.compact
      end
      alias :error_on :errors_on

    end
  end
end