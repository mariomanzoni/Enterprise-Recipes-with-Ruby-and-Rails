#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require File.dirname(__FILE__) + '/story_helper'

module Spec
  module Story
    describe Scenario do
      it 'should not raise an error if no body is supplied' do
        # given
        story = StoryBuilder.new.to_story
        
        # when
        error = exception_from { Scenario.new story, 'name' }
        
        # then
        error.should be_nil
      end
    end
  end
end
