#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'spec/matchers/have'

module Spec #:nodoc:
  module Matchers #:nodoc:
    class Have #:nodoc:
      alias_method :__original_failure_message, :failure_message
      def failure_message
        return "expected #{relativities[@relativity]}#{@expected} errors on :#{@args[0]}, got #{@actual}" if @collection_name == :errors_on
        return "expected #{relativities[@relativity]}#{@expected} error on :#{@args[0]}, got #{@actual}" if @collection_name == :error_on
        return __original_failure_message
      end
      
      alias_method :__original_description, :description
      def description
        return "should have #{relativities[@relativity]}#{@expected} errors on :#{@args[0]}" if @collection_name == :errors_on
        return "should have #{relativities[@relativity]}#{@expected} error on :#{@args[0]}" if @collection_name == :error_on
        return __original_description
      end
    end
  end
end
