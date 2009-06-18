#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
module Spec
  module Expectations
    class InvalidMatcherError < ArgumentError; end        
    
    class ExpectationMatcherHandler        
      class << self
        def handle_matcher(actual, matcher, &block)
          ::Spec::Matchers.last_should = "should"
          return Spec::Matchers::PositiveOperatorMatcher.new(actual) if matcher.nil?

          unless matcher.respond_to?(:matches?)
            raise InvalidMatcherError, "Expected a matcher, got #{matcher.inspect}."
          end
          
          match = matcher.matches?(actual, &block)
          ::Spec::Matchers.last_matcher = matcher
          Spec::Expectations.fail_with(matcher.failure_message) unless match
          match
        end
      end
    end

    class NegativeExpectationMatcherHandler
      class << self
        def handle_matcher(actual, matcher, &block)
          ::Spec::Matchers.last_should = "should not"
          return Spec::Matchers::NegativeOperatorMatcher.new(actual) if matcher.nil?
          
          unless matcher.respond_to?(:matches?)
            raise InvalidMatcherError, "Expected a matcher, got #{matcher.inspect}."
          end

          unless matcher.respond_to?(:negative_failure_message)
            Spec::Expectations.fail_with(
<<-EOF
Matcher does not support should_not.
See Spec::Matchers for more information
about matchers.
EOF
)
          end
          match = matcher.matches?(actual, &block)
          ::Spec::Matchers.last_matcher = matcher
          Spec::Expectations.fail_with(matcher.negative_failure_message) if match
          match
        end
      end
    end

  end
end

