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
    describe Story do
      it 'should run itself in a given object' do
        # given
        $instance = nil
        story = Story.new 'title', 'narrative' do
          $instance = self
        end
        object = Object.new
        
        # when
        story.run_in(object)
        
        # then
        $instance.should be(object)
      end
      
      it 'should not raise an error if no block is supplied' do
        # when
        error = exception_from do
          Story.new 'title', 'narrative'
        end
        
        # then
        error.should be_nil
      end
      
      it "should raise when error raised running in another object" do
        #given
        story = Story.new 'title', 'narrative' do
          raise "this is raised in the story"
        end
        object = Object.new
        
        # when/then
        lambda do
          story.run_in(object)
        end.should raise_error
      end
      
      it "should use the steps it is told to using a StepGroup" do
        story = Story.new("title", "narrative", :steps => steps = StepGroup.new) do end
        assignee = mock("assignee")
        assignee.should_receive(:use).with(steps)
        story.assign_steps_to(assignee)
      end

      it "should use the steps it is told to using a key" do
        begin
          orig_rspec_story_steps = $rspec_story_steps
          $rspec_story_steps = StepGroupHash.new
          $rspec_story_steps[:foo] = steps = Object.new
        
          story = Story.new("title", "narrative", :steps_for => :foo) do end
          assignee = mock("assignee")
        
          assignee.should_receive(:use).with(steps)
          story.assign_steps_to(assignee)
        ensure
          $rspec_story_steps = orig_rspec_story_steps
        end
      end
      
      it "should use the steps it is told to using multiple keys" do
        begin
          orig_rspec_story_steps = $rspec_story_steps
          $rspec_story_steps = StepGroupHash.new
          $rspec_story_steps[:foo] = foo_steps = Object.new
          $rspec_story_steps[:bar] = bar_steps = Object.new
        
          story = Story.new("title", "narrative", :steps_for => [:foo, :bar]) do end
          assignee = mock("assignee")
        
          assignee.should_receive(:use).with(foo_steps)
          assignee.should_receive(:use).with(bar_steps)
          story.assign_steps_to(assignee)
        ensure
          $rspec_story_steps = orig_rspec_story_steps
        end
      end
    end
  end
end
