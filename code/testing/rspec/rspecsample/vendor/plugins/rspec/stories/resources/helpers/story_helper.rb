#---
# Excerpted from "Enterprise Recipes for Ruby and Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msenr for more book information.
#---
require 'spec/story'
require File.dirname(__FILE__) + '/../../../spec/ruby_forker'

module StoryHelper
  include RubyForker

  def spec(args, stderr)
    ruby("#{File.dirname(__FILE__) + '/../../../bin/spec'} #{args}", stderr)
  end

  def cmdline(args, stderr)
    ruby("#{File.dirname(__FILE__) + '/../../resources/helpers/cmdline.rb'} #{args}", stderr)
  end
  
  Spec::Story::World.send :include, self
end
